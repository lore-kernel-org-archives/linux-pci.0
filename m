Return-Path: <SRS0=uFxo=EC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7EC55179
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B8A21707
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603815556;
	bh=0fTBCio73cytSnYXLa/MVltGcLwDRh17/0JCNzpy7VI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NREcxJ63CtXl27Ca28VIRlgafCp6f7S6ImRRchZ05KEXH12TqGiVGOYdIyNjAe0sC
	 RLky+oQx4o5KG8LnPZggn2tKDPhpZNpgfTahs/5fwPamGBVXWGlieHCkg6S3Gtmv+e
	 CtRgL55wE9i1QTjtn2/Rs5VRRW7xu4Vqk8DDpJNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1805652AbgJ0QTO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1796683AbgJ0QTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 12:19:13 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBEA621655;
        Tue, 27 Oct 2020 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603815553;
        bh=0fTBCio73cytSnYXLa/MVltGcLwDRh17/0JCNzpy7VI=;
        h=Date:From:To:Cc:Subject:From;
        b=0J2GqkK8zWPOQ1ccfjgikTys/kYzDZmB5O8/GmTeZqKCvntJv4ZtoSwexd6V0tbGD
         c5TwBSHpbXySh2Zuegg6mr5Kh06z/IUSoBmpRn3p1xZR7wdSe6eDfFDy0iOZAjYP3e
         qg/O+lGInBA46OZmBqSCHTPCrWTZsTiEXiKl0sjI=
Date:   Tue, 27 Oct 2020 11:19:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: pcie-mediatek.c coverity issue #1437218
Message-ID: <20201027161911.GA182976@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ryder,

Please take a look at this issue reported by Coverity:

 760 static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 761 {
 762        struct mtk_pcie *pcie = port->pcie;

CID 1437218 (#1 of 1): Wrong operator used
(CONSTANT_EXPRESSION_RESULT) operator_confusion: (port->slot << 3) & 7
is always 0 regardless of the values of its operands. This occurs as
an initializer.

    	Did you intend to use right-shift (>>) in port->slot << 3?

 763        u32 func = PCI_FUNC(port->slot << 3);
 764        u32 slot = PCI_SLOT(port->slot << 3);
