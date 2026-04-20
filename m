Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F323CEBB7
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716741; cv=none; b=fam4GwMDrq7kfb1HMdp8hBbJul79CFVUv1ZGP50cyBod+uTLAu89J/rT6ych24kDnBL6dz8/3mCvaWi4AaCnaS41wsE1lRwz1AeLFLLKas+EeNYiLr5sdYfW/1t0jG4aB+KpzdR9QsGw7PSZAWbWkS6L+Sm3o5mZuuA8COjU8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716741; c=relaxed/simple;
	bh=Dx76hdPmzkcK4nbwEphDzpwF8eLBrP39wXmhzcE1i9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCQZdVEEKzNcHw2RRVfqw0TZQCODAutW9gto3zF4+3EiaJmXqp3vq4Fxxw6bU68z80QQQn2TRWfQSaq2Q/YNWdsa3oTJ9zmruSp5i/Sqq0CKdv/000+5tddd5IuhJIHalmxvP79g2zuZP+fF38OoC7D6azcDoUqvI06ONGzB2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MwCSCJDj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MwCSCJDj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89fc4147f2eso39962296d6.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776716738; x=1777321538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86B2EppM//v3TWmEymAoj6QAs94Bt1WYW2cmbvlwvO8=;
        b=MwCSCJDjXbCvC3v1RscWJNQ6YOVZFVHPpzP1nFOPs+Pt2NtU0oJJ7oPNGqLFnDPktw
         JQivfdVMFtG/TTh19cK0LfNJTMpX6DhFeINI9+bXbdsjmVv/Ds59umoP3m2sMmDSj2Ov
         CW44m8KumgVPrHC7bHyyEY/UCqNky5Nh1uFJRf+yP89OeyEgx2bA5CXrFUOtN7utWTPa
         ysOTh8bHlSvAMd+jPHDO4f4GH21Ll0Y8xFjaWsOrhpB8PNyQhlp9FTNA2txcwDr/OUVB
         bCJYbYtioyIcLpcaPBQlLIgtHGnLAcHF+aDWum6zTiiHn7hQppMnqofiAZq6jOgpcDBu
         wvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716738; x=1777321538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86B2EppM//v3TWmEymAoj6QAs94Bt1WYW2cmbvlwvO8=;
        b=VchoTGytNrpXCJTpqp8LTlazTs8geBfEG/nB+F2HBMSCz0UANhVd1hm2b8amstHuSp
         rdrWRVskohr7LCAOHgkUEvP7TchBuNB2IBPxrW6+cIL26l0NFvnPbRf6RfgDu+35o1sG
         IZE5ZtcH0w07Qb3gGOnRnb06Nd3+U3prhBnXAoz9hPHXBUbG31mMKsBb4cWg0wij91gn
         4NHABIjN/YyU2GiQQA415YcupSxH56rIgOpIerroS3E51MiP05LRYGwOqiEl8YDSx1FH
         329LyWd10ZC7jP9bf8oxu6UGrfnW1F0MY9Z+3XC3Evp2WKk+mvFGmQiCPR0dSjfH20go
         vdeA==
X-Forwarded-Encrypted: i=1; AFNElJ/jDL5z50T3OR2Nhh3tbQN4AwQrp7Zqjm6zrjIfkLQ4SBGCxl++/6YOtoVDAc39oMhOzjy3g5bhOQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycdK8a/wykefe+1I9Qh96PkKD1OpIoRLsa0kooejhRlcbxgQcc
	rz0sBYOgMZ+w8CSXNnigiG3sOgeP8GSxVvtg6PXLv/DcxRsSppIEpEqoCzZ8F8AqwI4=
X-Gm-Gg: AeBDiesyvAkJtSzVLMU8ralTwaTRStOZdN8vfO4drhwRhYiQ31SvHznHX/XDFVUNoqJ
	C/jxDBs7PsBbBh7AX2XZAoKvMxSbahcGrYbLgY/bqv0tulWEPe8yOHC886e6q/Husq4aq6u5gbn
	CYkTYAaxfSz5AdE9Jf7fwdEo2f0c23gG4K22683mDuy7qgNp/Xkitg4NZN/Z1LbVTdlw3h22Xgu
	HKBCy6cKj0R6QF0LjFh5XYLUojv982hjRRZWcyDzs3kNldb/0xZcmJejUR9aG8WySSDkDOZubxd
	elE77a8qSbIQaIZNqk1SsXcb6oKUE4cXN+Oimp9ObWnGsuVBw0RTrDOsv1HfbDff2MfDg6Tpg3z
	qRn1JOiFA+KUdPstQ6lWPm+5inBuFh9GUxCVRYeNSR3kC4IIoObT8FX7kyIZqrNdYNcaGz5Y+X4
	GDysLRive3Ik5TBNfUh36ngmuXiLdqXCkyjKSQMnaxehV4OKC7rpacfzBSnmUw
X-Received: by 2002:a05:6214:3209:b0:8ac:ab90:d764 with SMTP id 6a1803df08f44-8b0281653a5mr266452836d6.48.1776716737948;
        Mon, 20 Apr 2026 13:25:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm85895836d6.13.2026.04.20.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:25:36 -0700 (PDT)
Date: Mon, 20 Apr 2026 20:25:34 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org
Subject: Re: [PATCH 1/5] driver core: separate function to shutdown one device
Message-ID: <h2r2jv4g2tednrybrmkn4d2dus3oalqsk3r2q4xrbuivucefon@n6vvx5bl5cm5>
References: <20260420152608.6244-1-djeffery@redhat.com>
 <20260420152608.6244-2-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420152608.6244-2-djeffery@redhat.com>

On 04-20 11:26, David Jeffery wrote:
> Make a separate function for the part of device_shutdown() that does the
> shutown for a single device.  This is in preparation for making device
> shutdown asynchronous.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>  drivers/base/core.c | 71 +++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 0613de0fbe44..5353c6c22d49 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4783,12 +4783,48 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  	return error;
>  }
>  
> +static void shutdown_one_device(struct device *dev)
> +{
> +	struct device *parent = dev->parent;
> +
> +	/* hold lock to avoid race with probe/release */
> +	if (parent)
> +		device_lock(parent);
> +	device_lock(dev);
> +
> +	/* Don't allow any more runtime suspends */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_barrier(dev);
> +
> +	if (dev->class && dev->class->shutdown_pre) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown_pre\n");
> +		dev->class->shutdown_pre(dev);
> +	}
> +	if (dev->bus && dev->bus->shutdown) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown\n");
> +		dev->bus->shutdown(dev);
> +	} else if (dev->driver && dev->driver->shutdown) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown\n");
> +		dev->driver->shutdown(dev);
> +	}
> +
> +	device_unlock(dev);
> +	if (parent)
> +		device_unlock(parent);
> +
> +	put_device(parent);
> +	put_device(dev);
> +}

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

Also, please CC: kexec@lists.infradead.org, this series helps the live 
update, and kexec performance.

Pasha
