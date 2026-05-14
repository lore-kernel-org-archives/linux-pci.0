Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C32FDC30
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723223; cv=none; b=QI0HuVMBFE941Cmvhp3E3zW/HdHa5oGSkiwqQmzPmzh8Dca0s2kCRA7uDnfZRSFYWCK4+gzwxelhGdEfRhlHUWTnP9b14vazJqtXPT24tLF1yGH3PbIEnhkYeXN5gBbInwX3ckqD7YpV3GMLWRNxrmudpJs9QtZ/uHaJLT62XYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723223; c=relaxed/simple;
	bh=PfmsXm2mdbhrvgf2sJed5utrda9tfjVi/R2MPTg8HIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RNpF3AAVY9DdYKv/xHJffRmumpzaBtbJl8jBa7Y0EQZlwmpPWL4RPp9mkeHQfUH+GEllGipPj/VI3GFG8/0aFBAFwIfrDq/vIRUAF7i/vrOdUngjH6PE2AZPl+4AhLxqfZccFCate/fU9NpQTju+G5xWpXL0OANjJ1bXEwCltM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXdi72y9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXdi72y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411AC19425;
	Thu, 14 May 2026 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723223;
	bh=PfmsXm2mdbhrvgf2sJed5utrda9tfjVi/R2MPTg8HIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BXdi72y9R5Cy7sNnvoL8q+j7R7b8SV3jOb6JEpWUhUiPrKQ8OYLSmTKtTL/nM++oY
	 y5PEMZNlnmdl0fPR6B+3igByUyKQDb5b56HdZQU+pLmD4D46Qzsr7ITKuBMPQbRUDD
	 3qHdiv92NfmLYWVVKPSn9lG3wAe4P+79fWpb273N8tO0OD/JJ+qw6R8FayETRi0OH4
	 ISVYgU+h+x8FWJpxfWukyhERRlb/0ExfRbtVasZlHh9tGhXq5bO/wWAewGEluYS/Ff
	 ivJ54GEXE2bcWE9oa5dPrP6D3UIy7LAAD2fzSQaxgsp/MXik1WlPz/kbCLY5lMJl4k
	 5SC2w4ijLgJXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/sysfs: Check if device disabled in resource mmap
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Kumar Bandi" <ravib@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260513041332.24105-1-ravib@amazon.com>
References: <20260513041332.24105-1-ravib@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:47:02 +0000
Message-Id: <20260514014702.D411AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `pci_dev_is_disconnected()` check fails to block mmaps on soft=
-unplugged devices and contradicts the commit's stated intent.
--

commit fff70a5b941929593fed8b551604aadd9e28748d
Author: Ravi Kumar Bandi <ravib@amazon.com>

PCI/sysfs: Check if device disabled in resource mmap handler

This commit adds a check to pci_mmap_resource() to prevent mapping a PCI BAR
resource into userspace if the device is disconnected. The stated intent is=
 to
block new mmaps after a device has been marked disabled or soft-unplugged.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260c..83d580256c4b2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj, =
const struct bin_attribute *a
>  	if (ret)
>  		return ret;
> =20
> +	if (pci_dev_is_disconnected(pdev))
> +		return -ENODEV;
> +

The commit message mentions that this change prevents new mmaps after a dev=
ice
has been marked disabled or soft-unplugged. Does this check accurately capt=
ure
a soft-unplug?

Looking at pci_dev_is_disconnected(), it strictly checks if the device's
error_state is pci_channel_io_perm_failure. This state is typically set
during surprise hotplug removals or fatal PCIe errors.

During a graceful driver unbind or a soft-removal via sysfs, the error_state
remains pci_channel_io_normal. Would a concurrent mmap() on an already-open
file descriptor still succeed during the window before the sysfs files are
completely removed, bypassing this protection?

Additionally, if the intention was to literally check if the device is disa=
bled
(as the commit subject suggests), would that introduce a regression for
userspace? Valid userspace tools, such as X servers or VFIO utilities, often
map PCI BARs prior to explicitly enabling the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513041332.2410=
5-1-ravib@amazon.com?part=3D1
