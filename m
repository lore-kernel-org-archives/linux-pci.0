Return-Path: <SRS0=1R7R=UF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D3C04AB5
	for <linux-pci@archiver.kernel.org>; Thu,  6 Jun 2019 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E5620673
	for <linux-pci@archiver.kernel.org>; Thu,  6 Jun 2019 22:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFFWdW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:33:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46173 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfFFWdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 18:33:14 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b1e59abe70cc4a25; Fri, 7 Jun 2019 00:33:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] PCI: PM: Optimization and cleanup
Date:   Fri, 07 Jun 2019 00:28:16 +0200
Message-ID: <2958812.87Qy2A3tJo@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is a v2 of the patch at

https://patchwork.kernel.org/patch/10969867/

and a cleanup of the PCI PM code modified by it as discussed with Bjorn in the
thread started by that patch.

Thanks,
Rafael



