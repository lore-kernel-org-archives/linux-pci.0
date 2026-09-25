Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC4284880
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373742; cv=none; b=UwseYgLCFG4RYgu8dpxe4d9dflArAmqVceOJvTvQ9EDUIqQwiFtBdCwZsBoMCOg3SSCoWhdpNe7ebiPPbokGoee4QC2E2X0LzxfMApPnRNMLhp4ivTPtGXDJh9yupIxPIKqPdhdI4SfHmXw2+4LffWc7OCLR1+BY0xyYxBjAgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373742; c=relaxed/simple;
	bh=Sdw/4PU3ATqwoITo6ov3YJFuGHvP2Kr/Pi2JJRgz2+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dfVaba6Ztk3WIJWJn2wZSeP0hYwc2N7VAQSyr5tNpdtoC6Hbkw3nez5ObgHi6LwKHd5nivDbkO9s/EtC41DWpYs6EjYxwWajfhsk7ai48Tsc62ZQIjYpd2snqjf7wqgqWqFTxNYGbMDgDMMIy+5obyC5lKUPVlnPksQUjUAYtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBgbc9lX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBgbc9lX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A081F000FF;
	Fri, 25 Sep 2026 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373741;
	bh=Ez2RkFQVOKHJMV4hGDYPVkCgk/7aAsJv5trFVaPVPfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MBgbc9lXWjZqGkMNuk1TVPExqfPjs3nTFvvuO0MfFWEfayMDopF4Z/rLMCJ3vgYRW
	 hNzfmtA4fFGFX2Qcmo7ZrqqCiMSgIVxEcP2Ema5UTx3HJnceTS5yMEkdcr6AW+Fbbo
	 lqVsk1s6M8Ozu9kSDjmVqa4p327zbrmnQDKfiZfhSVJ73qyfbYhjnQ9kdZNY/YbaCa
	 xmqeDxQZOrhKy6xeBPERjTnBXL5FgPLtTuDgjdhLhWRbNLRcBQht55t0sm2rybU2pi
	 /fwd0tDEar+GDxvkXUr9xf1GhZtdqgign8f4+nI0uOCArNXMI2tbBiOjFXY+lrbeD1
	 HVK4rsyAyoK9g==
Date: Fri, 25 Sep 2026 17:02:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Narendra K <Narendra_K@dell.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/sysfs: Decouple acpi_index from the optional
 device name element
Message-ID: <20260925220219.GA2106266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814070522.2327975-3-kwilczynski@kernel.org>

On Fri, Aug 14, 2026 at 07:05:20AM +0000, Krzysztof Wilczyński wrote:
> Currently, dsm_get_label() validates both elements of the Device Name
> _DSM result in a single conditional.  The _DSM returns an ACPI package
> of two elements, the instance number and the device name, where the
> instance number is mandatory and the name is optional.  Firmware that
> implements no name must return a NULL string for it.
> 
> Reads of "acpi_index" therefore fail whenever the name element is
> malformed.  That attribute exports only the instance number, and the
> two elements do not depend on each other.
> 
> Thus, validate each element only for the attribute that exports it.
> So "acpi_index" now depends on the instance number alone, and "label"
> reads fail with -EIO when the name element is neither a string nor a
> buffer.  The package elements pointer is read only after the object
> type has been checked.
> 
> On platforms with a valid instance number and a malformed name element
> the "acpi_index" attribute starts returning data.  Because udev derives
> the onboard interface name from "acpi_index", an interface on such a
> platform may be renamed once, on the first boot after this change.
> That is the attribute assuming the value the firmware always
> provided.
> 
> Link: https://github.com/pciutils/pciutils/issues/175
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-label.c | 55 +++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 255e0ecffb09..5b08f50653a3 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -157,7 +157,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>  {
>  	acpi_handle handle = ACPI_HANDLE(dev);
>  	union acpi_object *obj, *tmp;
> -	int len = 0;
> +	int len;
>  
>  	if (!handle)
>  		return -ENODEV;
> @@ -167,30 +167,43 @@ static int dsm_get_label(struct device *dev, char *buf,
>  	if (!obj)
>  		return -EIO;
>  
> -	tmp = obj->package.elements;
> -	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 2 &&
> -	    tmp[0].type == ACPI_TYPE_INTEGER &&
> -	    (tmp[1].type == ACPI_TYPE_STRING ||
> -	     tmp[1].type == ACPI_TYPE_BUFFER)) {
> -		/*
> -		 * The second string element is optional even when
> -		 * this _DSM is implemented; when not implemented,
> -		 * this entry must return a null string.
> -		 */
> -		if (attr == ACPI_ATTR_INDEX_SHOW) {
> -			len = sysfs_emit(buf, "%llu\n", tmp->integer.value);
> -		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
> -			if (tmp[1].type == ACPI_TYPE_STRING)
> -				len = sysfs_emit(buf, "%s\n",
> -						 tmp[1].string.pointer);
> -			else if (tmp[1].type == ACPI_TYPE_BUFFER)
> -				len = dsm_label_utf16s_to_utf8s(tmp + 1, buf);
> -		}
> +	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 2) {
> +		len = -EIO;
> +		goto out;
>  	}
>  
> +	tmp = obj->package.elements;
> +	if (tmp[0].type != ACPI_TYPE_INTEGER) {
> +		len = -EIO;
> +		goto out;
> +	}
> +
> +	if (attr == ACPI_ATTR_INDEX_SHOW) {
> +		len = sysfs_emit(buf, "%llu\n", tmp[0].integer.value);
> +		goto out;
> +	}

Makes sense, the sysfs 'acpi_index' attribute should now work even if
the second package element (the 'label') is the wrong type.

What if we want the 'label', but the first element is the wrong type?
It looks like this will fail before looking at the second element.

What if there's only one element?  I think this will fail (as it did
previously), but we might still be able to make 'acpi_index' work.

IMO the spec is poorly worded.  It describes the string name as "This
string is optional" and "when implemented", so I could see an
implementation returning a package with a single element.

If they wanted to require a second element, it should have said "the
second entry is mandatory but may be a null string."

> +	/*
> +	 * Per PCI Firmware r3.3, sec 4.6.7, the device name is optional
> +	 * even when this _DSM is implemented. When not implemented, this
> +	 * entry must return a NULL string.
> +	 */
> +	switch (tmp[1].type) {
> +	case ACPI_TYPE_STRING:
> +		len = sysfs_emit(buf, "%s\n", tmp[1].string.pointer);
> +		break;
> +	case ACPI_TYPE_BUFFER:
> +		len = dsm_label_utf16s_to_utf8s(&tmp[1], buf);
> +		break;
> +	default:
> +		len = -EIO;
> +		break;
> +	}
> +
> +out:
>  	ACPI_FREE(obj);
>  
> -	return len > 0 ? len : -EIO;
> +	return len;
>  }
>  
>  static ssize_t label_show(struct device *dev, struct device_attribute *attr,
> -- 
> 2.55.0
> 
