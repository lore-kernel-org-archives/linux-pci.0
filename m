Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C2C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB947206B6
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfDPR7F (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:59:05 -0400
Received: from xes-mad.com ([162.248.234.2]:58698 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbfDPR7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 13:59:05 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 13:59:05 EDT
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 200862021D;
        Tue, 16 Apr 2019 12:52:53 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: Improve _OSC control request granularity
Date:   Tue, 16 Apr 2019 12:52:53 -0500
Message-Id: <20190416175253.786-1-asierra@xes-inc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213242.21920-1-asierra@xes-inc.com>
References: <20190213213242.21920-1-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Just checking if this is still on your radar. Has it been superseded or
complicated by other work?

Aaron
