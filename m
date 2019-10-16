Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D2DFA372B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 10:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C72168B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 10:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbfJPKcA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:32:00 -0400
Received: from foss.arm.com ([217.140.110.172]:35480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJPKcA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 06:32:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E660328;
        Wed, 16 Oct 2019 03:31:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CB0C3F6C4;
        Wed, 16 Oct 2019 03:31:59 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:31:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc:     linux-pci@vger.kernel.org
Subject: Mobiveil legacy IRQ binding erroneous interrupt-map
Message-ID: <20191016103156.GC22848@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hou, Karthikeyan,

I have just noticed the mobiveil interrupt-map DT bindings example
is wrong:

This:

interrupt-map = <0 0 0 0 &pci_express 0>,
		<0 0 0 1 &pci_express 1>,
		<0 0 0 2 &pci_express 2>,
		<0 0 0 3 &pci_express 3>;

should be:

interrupt-map = <0 0 0 1 &pci_express 0>,
		<0 0 0 2 &pci_express 1>,
		<0 0 0 3 &pci_express 2>,
		<0 0 0 4 &pci_express 3>;

Legacy IRQs Interrupt pins map this way:

{{1, INTA}, {2, INTB}, {3,INTC}, {4,INTD}}

(as read from Interrupt pin register in the config space header) (ie
refer to PCI local bus specification 3.0), please fix it as soon as
possible.

Lorenzo
