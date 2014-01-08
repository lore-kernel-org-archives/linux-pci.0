Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vladimir Kondratiev <qca_vkondrat@qca.qualcomm.com>
To: Alexander Gordeev <agordeev@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<wil6210@qca.qualcomm.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 7/7] wil6210: Use new interfaces for MSI enablement
Date: Wed, 8 Jan 2014 13:30:45 +0200
Message-ID: <1649789.pNiBbZVqTd@lx-vladimir>
In-Reply-To: <a5774459cb8eebfc95156b8cd3b249d896e04400.1389103215.git.agordeev@redhat.com>
References: <cover.1389103215.git.agordeev@redhat.com> <a5774459cb8eebfc95156b8cd3b249d896e04400.1389103215.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 07, 2014 07:05:42 PM Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/net/wireless/ath/wil6210/pcie_bus.c |   36 ++++++++++++++------------
>  1 files changed, 19 insertions(+), 17 deletions(-)
> 

Patch looks fine, but I can't validate it as I can't find patch introducing
pci_enable_msi_range(). Where this patch landed on?

I am working with:
git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git

I also checked
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
and, of course
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Thanks, Vladimir
