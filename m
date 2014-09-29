Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:41269 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbaI2NgG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 09:36:06 -0400
Received: by mail-qa0-f41.google.com with SMTP id cm18so8695359qab.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2014 06:36:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5425961A.5000604@gmail.com>
References: <5425961A.5000604@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 29 Sep 2014 07:35:45 -0600
Message-ID: <CAErSpo6YEMg1E5KQxFxBTekwAcDvmE0hvsg9MzU-8HJrO9TDAA@mail.gmail.com>
Subject: Re: [PATCH] xen/xenbus: Use 'void' instead of 'int' for the return of xenbus_switch_state()
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: David Vrabel <david.vrabel@citrix.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ian Campbell <ian.campbell@citrix.com>, wei.liu2@citrix.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	mukesh.rathor@oracle.com,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 26, 2014 at 10:36 AM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
> When xenbus_switch_state() fails, it will call xenbus_switch_fatal()
> internally, so need not return any status value, then use 'void' instead
> of 'int' for xenbus_switch_state() and __xenbus_switch_state().
>
> Also need be sure that all callers which check the return value must let
> 'err' be 0.
>
> And also need change the related comments for xenbus_switch_state().
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/block/xen-blkback/xenbus.c |  9 ++-------
>  drivers/net/xen-netback/xenbus.c   |  5 +----
>  drivers/pci/xen-pcifront.c         | 15 ++++++---------
>  drivers/xen/xen-pciback/xenbus.c   | 21 ++++-----------------
>  drivers/xen/xen-scsiback.c         |  5 +----
>  drivers/xen/xenbus/xenbus_client.c | 16 ++++++++--------
>  include/xen/xenbus.h               |  3 ++-
>  7 files changed, 24 insertions(+), 50 deletions(-)

I don't know enough to review this, but as far as I'm concerned, the
Xen folks own drivers/pci/xen-pcifront.c, so whatever they want to do
is fine with me.

Bjorn
