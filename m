Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06951C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92082070D
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCYNZR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:25:17 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:42427 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCYNZR (ORCPT
        <rfc822;groupwise-linux-pci@vger.kernel.org:8:2>);
        Mon, 25 Mar 2019 09:25:17 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 25 Mar 2019 07:25:15 -0600
Message-Id: <5C98D6B502000078002219FB@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Mon, 25 Mar 2019 07:25:09 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Gustavo A.R.Silva" <gustavo@embeddedor.com>
Cc:     <keescook@chromium.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] PCI: Mark expected switch
 fall-throughs
References: <20190320182715.GA9406@embeddedor>
In-Reply-To: <20190320182715.GA9406@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>>> On 20.03.19 at 19:27, <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/pci/proc.c: In function ‘proc_bus_pci_ioctl’:
> drivers/pci/proc.c:216:6: warning: this statement may fall through 
> [-Wimplicit-fallthrough=]
>    if (arch_can_pci_mmap_wc()) {
>       ^
> drivers/pci/proc.c:225:2: note: here
>   default:
>   ^~~~~~~
> 
> drivers/pci/xen-pcifront.c: In function ‘pcifront_backend_changed’:
> drivers/pci/xen-pcifront.c:1105:6: warning: this statement may fall through 
> [-Wimplicit-fallthrough=]
>    if (xdev->state == XenbusStateClosed)
>       ^
> drivers/pci/xen-pcifront.c:1108:2: note: here
>   case XenbusStateClosing:
>   ^~~~
> 
> Notice that, in this particular case, the /* fall through */
> comment is placed at the very bottom of the case statement,
> which is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.

None of the above explains why ...

> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -1104,7 +1104,7 @@ static void __ref pcifront_backend_changed(struct xenbus_device *xdev,
>  	case XenbusStateClosed:
>  		if (xdev->state == XenbusStateClosed)
>  			break;
> -		/* Missed the backend's CLOSING state -- fallthrough */
> +		/* fall through - Missed the backend's CLOSING state. */

... the original comment here wasn't good enough.

Jan

