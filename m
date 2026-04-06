Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE84392C43;
	Mon,  6 Apr 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496207; cv=none; b=ggwkfOsYc+WMtkq6NuCoXqN/RoXXz2cgWL/dw1yIAO/V5RzqfEl6B1rlI3kg/eKFn1mcw7VZ5mNB34rzb85O3WkGcYaImXz4BtUmZqSC891u6noPWEt4Cpmk8g+Kg9yVcbu5kp/yvDyAKHkBQSqGjExn2H/mDiHiK25mT6agebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496207; c=relaxed/simple;
	bh=vR3199kLvZYm67EEM95+/yzuCiQiYSZbB35e/+5x4ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jeSxH/m/ciYYWhn6m2Nz21Ln0Q6hSd514rcVE7IpAhgnabkRH9n0PoAisqZFRqQFqzn0WyqRBDolNQI+EY8+HkSqohPr8sk0j8ldUXRFXvD7DhvtR3aIY8Pp2a7Q/kM/veGCo8y69FqiR2NXCiodM8UolEvFpcJedTPfq/kFWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VznjjhCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VznjjhCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C98C4CEF7;
	Mon,  6 Apr 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775496206;
	bh=vR3199kLvZYm67EEM95+/yzuCiQiYSZbB35e/+5x4ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VznjjhCa+wrH29jjMmE7BiOrwtIXWJJduLFHF0y41tR+DPCOP4BBXpdklvuFnCcG1
	 4iOL+PbXbXFyF6s3GnkGueYT08aBSoELrVk04JZDgbV2nj8a84zGwErD1nlXqaCQB1
	 JeGkaaQm0v89TxlFJjJx4edXmjVM/3oSd4Mc699aGtMlv47U+PgGuDKBLtCgL1Vlwx
	 hSKcSKaa+Q4fgPQsS5WEOMCRINVhRX4faLUfzgbCEdnTH+9sYemoC0CbYrWjkpyY/+
	 VgLhqDxFg3Ya/IbzWhSfNK6Lz4jWJ5lzdTj2URSvkgqvQpykHRDFjkH3TYWgOSB9GZ
	 D7o+AatVO4ynA==
Date: Mon, 6 Apr 2026 12:23:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] input: pc110pad: change PCI check to get rid of
 orphaned no_pci_devices
Message-ID: <20260406172324.GA170281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf519463-775a-4d43-be38-20742fdad407@gmail.com>

On Fri, Apr 03, 2026 at 12:17:35AM +0200, Heiner Kallweit wrote:
> As a prerequisite for removing no_pci_devices(), replace its usage here
> with an equivalent check for presence of a PCI bus.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/input/mouse/pc110pad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
> index efa58049f..c7a6df210 100644
> --- a/drivers/input/mouse/pc110pad.c
> +++ b/drivers/input/mouse/pc110pad.c
> @@ -91,7 +91,7 @@ static int __init pc110pad_init(void)
>  {
>  	int err;
>  
> -	if (!no_pci_devices())
> +	if (pci_find_next_bus(NULL))
>  		return -ENODEV;

I'd certainly love to get rid of no_pci_devices(), although using
pci_find_next_bus() is not really much better.

I don't have much opinion about pc110pad.c change.  It's essentially
still the same kludge, which has been there at least since the
beginning of git history.

Dmitry, if you want to ack this, I can take both together.

Bjorn
