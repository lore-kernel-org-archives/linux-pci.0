Return-Path: <SRS0=Xta/=UD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF44C04AB5
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 03:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503772454A
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 03:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFDDiE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Jun 2019 23:38:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:34384 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDDiE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 23:38:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x543bnxo024939;
        Mon, 3 Jun 2019 22:37:50 -0500
Message-ID: <f690d57b8b842c6d4724f75854793cb607562d21.camel@kernel.crashing.org>
Subject: Re: [RFC] ARM64 PCI resource survey issue(s)
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Tue, 04 Jun 2019 13:37:49 +1000
In-Reply-To: <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-04 at 13:32 +1000, Benjamin Herrenschmidt wrote:
> 
> > Of course, _DSM *can* be higher, e.g., at the host bridge, but then we
> > lose the information about what specifically must be immutable, and
> > that means the OS cannot ever move *anything*, even if it becomes
> > capable of moving things around to accommodate hot-added devices.
> 
> Well, in our case at least this is a non-issue, we don't want the OS to
> move anything or change anything and there is no hotplug.

Correction: There is hotplug in the leaf ports, but the FW will have
setup the switch with enough space already.

Cheers,
Ben.


