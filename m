Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C58371899
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023991; cv=none; b=qqeYJwGXJHxS5htZmIKn4hLgYuDh5v86UPX5qU5yOxmNMgy0jbqqgjQOhbgrVV0niTGLj94735Cbie7T//2JvEDQf/WOia4eFF2ykbDbN2pa6EQ+0FGhhW6ezLggW8zqPZRD7kw4otSjl8sYsZh4GJhg+FYQmABYoahcFUk20T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023991; c=relaxed/simple;
	bh=+g05DjB56ySMW+B4jdwbtvbaoyXTnFkS8nW7wfufUJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME5321Mt+LC2CdxWsxwFJitw0F06TgFJEdGiWjGm3k3lJQSBoVGQ2uNIL5bkqa0El3W03JnSNNsV1M5Z+29yu0GHELgHy61V63jteQHxgIbHNlLytXSWTJv2rcdjn5uwPbDXkhUeM7LBpwXAHLoQpwTKebnWZlYrtvNF5eryABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY8oaFnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY8oaFnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DA01F000FF;
	Thu, 10 Sep 2026 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789023989;
	bh=pK43JFOvV77lxcj/kgtXIGPlD3ykSPouBvio4fMmCmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NY8oaFnIefT+hHwHbBxur3QreS958SEIBoHbFhZBMnmZKyJrkH9SizmNJUJyhE8nH
	 sNe1ZpySk9/fyaj9Hjz+yHP179Yp66vNLX+rD3IwBp4OwRjcgt6FOMWA4DTWpGnOSt
	 eIi4K9uK9knxgoYyOkJTIQCZ2+xA1bEbvN7EGZ2s2lOpQa5uf7Ps15HkIG9RC091aT
	 1+rLpD4LIk6CcRfoepv3X5zvxmnt0xVyurqCgnQJCZqa1BQQ1kdOS5RJ0wsCdCfoBw
	 B0NTyxUo3Pd6f4jQt5QoKSb3HcQln5H1IYzjXIBmked/s8FSYGMLxBjb6EmLc8XtfV
	 0PXIIfxL6jKdA==
Date: Thu, 10 Sep 2026 09:06:23 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Power off child devices on power-on failure
Message-ID: <gxmw6wqlzwfw5ldinbzi6twvkh6z6jx3pgwkyl2qblizhaviyq@vlw6ljo4gc6b>
References: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:28:29PM +0200, Lorenzo Bianconi wrote:
> pci_pwrctrl_power_on_device() recursively powers on the child nodes
> of a device before powering on the device itself. If powering on a
> child fails (e.g. returning -EPROBE_DEFER), the function returned
> immediately, leaving the sibling children that were already powered
> on in the same loop iteration enabled.
> 
> Since probe deferral is a standard boot path, this leads to unbounded
> regulator and clock enable increments across retries. The error path
> in pci_pwrctrl_power_on_devices() only powers off the top-level
> children processed before the failing one and explicitly stops at it,
> so it can never clean up the siblings leaked deeper in the failed
> subtree.
> 
> Power off the sibling children that were successfully powered on
> before a child fails, and power off all children if the device's own
> power_on() fails after its children were already enabled. Switch to a
> manual child iterator so the failing node can be tracked and its
> reference released in the error path.
> 
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
