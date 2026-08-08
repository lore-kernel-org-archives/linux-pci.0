Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E0415F10;
	Sat,  8 Aug 2026 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194608; cv=none; b=uZLZHfec4e3nn9sS9Uut/RixEe5OT8eeMhcavjoaom6FP2zYDUiaw0Zz/MOTzaVwhgGbPfKgsoxtrHN+gPUR6vGVvH3DwxsDoXg+hYZ+oO3recgxJsVQGixiGAJR/E1noUKm2WlvSEIGL8TvnroTHAFBLlhcMdeCxXImaANFVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194608; c=relaxed/simple;
	bh=fr3bS5GlrTWlBf7aT/KNHnWHhjka8Q/sSUca+lFQC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxuToZae9vOx0dutZFZzV38t6bRSwLwD8E9AgmGy1ICQmMmiyFNm8ivWoIn0jWhV5QOosZp7ZMD9Indb8Mj/5ACo0WetfI6p4rNJKLw7xEW31E/0iMClBcSLUlbx0PLlQymXU5G/zu88qz+IbcngclJpYHYNvmt2Zv2IWSlo/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SRd9t2ad; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SRd9t2ad"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0A87D1A14D2;
	Sat,  8 Aug 2026 13:10:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3C326045E;
	Sat,  8 Aug 2026 13:10:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D95B11C484B0;
	Sat,  8 Aug 2026 15:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786194597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=d6Ombx8W2xUsoJI4UirYQflZ8xZfFceChNXFr4Zl2Wg=;
	b=SRd9t2adlKOOM5gJobjr7CUU7eoDzspr4QqX+OzexssJTVz1APrfCVp4oRR657bVbdMuc0
	G9vtTIlPbKPcqdN0C0QPsIPVewFo3LGaPYhn4Du4/1z3kkqUJVgwANhWclukAIanqH6Gmj
	EY3u6QuPmh5N+ObS6I+PRYf3ufkiYkm/jUPK8Bl8gSAWYF9/9SC6xtH9gCKNyyHdfEnTC0
	EjcW6VRfMR17dlMwy7Yiq8F15bojmbs8vqaA1TjLPZXGtPijwu+/Fe1VFIQiIbsPKLi8zu
	nVzFgM536D6uQDOpTGpS+ciSkyJt4Eys/nSWHJoqmARzn3Warvum4qzFx/2iWA==
Date: Sat, 8 Aug 2026 15:09:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 00/14] i3c: Support IBI-based system wakeup
Message-ID: <178619453324.3720475.10667925428274179741.b4-ty@b4>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 07 Aug 2026 17:56:24 +0300, Adrian Hunter wrote:
> 	Note: all patches except patch 7 now have Frank's Rev'd-by
> 
> 
> Intel LPSS I3C controllers support up to two I3C busses and can wake the
> system from an In-Band Interrupt (IBI) via a PCI PME.  Today that wakeup
> capability lives only at the PCI function, with no way to express which
> I3C device is actually responsible for waking the system, and no way for
> user space to enable or disable wakeup on a per-device basis.
> 
> [...]

Applied, thanks!

[01/14] i3c: master: Fix recursive locking during device registration
        https://git.kernel.org/i3c/c/456f832e5fc2
[02/14] i3c: Fix unlocked dereference of dev->desc in i3c_device_get_supported_xfer_mode()
        https://git.kernel.org/i3c/c/8bed7f4fa710
[03/14] i3c: master: Do not treat master device as a duplicate target
        https://git.kernel.org/i3c/c/4dc1b3eeba79
[04/14] i3c: master: Fix use-after-free of master->this
        https://git.kernel.org/i3c/c/feb0ed76601f
[05/14] i3c: Make dev->desc locking assumptions explicit
        https://git.kernel.org/i3c/c/4083d192f6f3
[06/14] i3c: master: Fix potential UAF in i3c_device_uevent()
        https://git.kernel.org/i3c/c/e5e8dd2e959f
[07/14] i3c: master: Fix potential UAF in i3c_device_match()
        https://git.kernel.org/i3c/c/f44d3b15326c
[08/14] i3c: master: Support IBI-based wakeup capability
        https://git.kernel.org/i3c/c/9fd18a865591
[09/14] i3c: master: Report wakeup events for IBIs
        https://git.kernel.org/i3c/c/ff2b20f8f1ff
[10/14] i3c: master: Add helper to query bus wakeup requirements
        https://git.kernel.org/i3c/c/60ff731f0690
[11/14] i3c: master: Reject IBI requests from non-IBI-capable devices
        https://git.kernel.org/i3c/c/087efc8e88e2
[12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
        https://git.kernel.org/i3c/c/94da8edf849b
[13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
        https://git.kernel.org/i3c/c/842e46925ef9
[14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
        https://git.kernel.org/i3c/c/1421e948a32a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
