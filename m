Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687B23183F
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416908; cv=none; b=mYmuzIjUEdeb10SGnyQvnQ+RXfRYDm59uz3I79xzqJTd3XxZUFr2p0/X2KCzZz7arykW58qr0AD0/kr+ct4nSUwNFBYJD8DH7sibfbFxHVrwIJdgF6AqrbHoumxz25CoQJvRX0GFroP/7TR8RngpeRnUZm30PublWwHX7HZwvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416908; c=relaxed/simple;
	bh=4QIFGvFfg4LSWRydXVNM8TvmNgmijeL6c2LThIuq+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZuU7wRWYksuy4vjyW315vth87W6QjzxNCG3LNRBjtFAaXhnIB/9MSbzonxof/AL/ZeOVqIdQc0yuT5fWJ/unfIsNQf5EUl/IPpYU5rzs6v3a5W8uipYaGykmA18NqZ/Amasrd3IdBSlMjQgtFTbK0yoNZ4gbWfJMlPBlB6sswcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4gY9fKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4gY9fKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB968C116C6;
	Fri,  6 Feb 2026 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416908;
	bh=4QIFGvFfg4LSWRydXVNM8TvmNgmijeL6c2LThIuq+4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r4gY9fKNZSIYkKwzxtJ9FAvasilXCzSvelXuXMd78N3A23EYF8kAk0NBMjE+z+uKD
	 UDXylHAw9PMX5Wm3jITE3ai3AjdImFGQHei5iJDX8qmqMrJ3k/ErrZuFrD45pH5JUb
	 PSLpPECKYtYxkVTXAFA2wJEwBvQjqrJzpDExTCHzoX84uMIY9oaTdpdR/1YlUSsfQc
	 fvJdh5duePbULMKYIjCTu0XraKDkPmP3CsKusc6Z0SyUcJgt9N1xbgKsP2o0mOYurq
	 cOKkoFfy5ziIQ/SAbp1kYUAgVwHxp8TlgkInffgfLgz8jZBzbcojV/Bjle2ZBW/FJq
	 ZSDMb76GB2tng==
Date: Fri, 6 Feb 2026 16:28:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: qinyuntan <qinyuntan@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260206222826.GA98751@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88437e1a-2df0-41e6-a58f-dcc68d4458bc@linux.alibaba.com>

On Fri, Jan 30, 2026 at 12:53:25PM +0800, qinyuntan wrote:
> Hi All,
> 
> Thank you all for the insightful discussion!
> 
> I agree with Leon's point that not all devices are created equal when it
> comes to SR-IOV handling during driver unbind.
> 
> Looking at existing driver implementations, I found two different
> approaches:
> 
> 1) mlx5 - unconditionally disables SR-IOV in remove:
> 
>    drivers/net/ethernet/mellanox/mlx5/core/main.c:
>    static void remove_one(struct pci_dev *pdev)
>    {
>        ...
>        mlx5_sriov_disable(pdev, false);
>        ...
>    }
> 
>    drivers/net/ethernet/mellanox/mlx5/core/sriov.c:
>    void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
>    {
>        struct mlx5_core_dev *dev  = pci_get_drvdata(pdev);
>        struct devlink *devlink = priv_to_devlink(dev);
>        int num_vfs = pci_num_vf(dev->pdev);
> 
>        pci_disable_sriov(pdev);  /* Always disable, no pci_vfs_assigned()
> check */
>        devl_lock(devlink);
>        mlx5_device_disable_sriov(dev, num_vfs, true, num_vf_change);
>        devl_unlock(devlink);
>    }
> 
> 2) ixgbe - checks pci_vfs_assigned() and skips disable if VFs are in use:
> 
>    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
>    static void ixgbe_remove(struct pci_dev *pdev)
>    {
>        ...
>    #ifdef CONFIG_PCI_IOV
>        ixgbe_disable_sriov(adapter);
>    #endif
>        ...
>    }
> 
>    drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:
>    #ifdef CONFIG_PCI_IOV
>        if (pci_vfs_assigned(adapter->pdev)) {
>            e_dev_warn("Unloading driver while VFs are assigned - VFs will
> not be deallocated\n");
>            return -EPERM;
>        }
>        pci_disable_sriov(adapter->pdev);
>    #endif
> 
> Regarding the warning level discussion: I would prefer keeping it as
> dev_warn() rather than downgrading to dev_info(). As Leon mentioned,
> some devices do require SR-IOV to be disabled when the PF is unbound,
> and for those cases, this warning is important for operators to notice
> and take action. A warning level helps ensure it doesn't get lost in
> normal system logs.
> 
> Please let me know how you'd like to proceed.

"driver left SR-IOV enabled after remove\n" is KERN_WARNING today, and
I'm OK with leaving it that way.
