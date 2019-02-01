Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E9C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71DA2148D
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549057976;
	bh=sZzhCS1uc1j4a6Z8PxLIZVpdbAyG/ZXwiVn3qt4dcts=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HsLvG2Bmym5vgCVC4ikDUyQwnVXJfT77aZNWUbgPT4e/o8Nzea1voQS5z5aUaK4XJ
	 ygz014w5WCEHr1CGUfxxfLOL+Aurv9DubcA/QQcaTI/o9qVghpH+E+sQrQGJoAHc45
	 PESLwKOjn129uZLROF82hNOxQyRK+0zqL/a86Y1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfBAVw4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfBAVwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 16:52:55 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F8420863;
        Fri,  1 Feb 2019 21:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549057975;
        bh=sZzhCS1uc1j4a6Z8PxLIZVpdbAyG/ZXwiVn3qt4dcts=;
        h=Date:From:To:Cc:Subject:From;
        b=IFI+p38OFcIvaXu1SzzJA2iLsCwTPM2aElPi7Qwpn0D7YdX0lFgsKrEF3bhqKTMre
         co20sVcEURmVNIpUooiAyCG/pF3wkEzD98MnXtEnQ3lKxJuPXVsdbTpmlwNAJjcEBO
         d5IgYXjSVRYELCIEMg5tcurbLScaVs5MombTjPRE=
Date:   Fri, 1 Feb 2019 15:52:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Robert Smith <robert.smith51@protonmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sinan Kaya <okaya@kernel.org>, linux-kernel@vger.kernel.org
Subject: PCI extended tags regression: 3ware 9650SE-2LP RAID controller not
 working on AMD Ryzen system
Message-ID: <20190201215249.GT229773@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

See https://bugzilla.kernel.org/show_bug.cgi?id=202425.

Robert bisected a problem with a 3ware 9650SE-2LP controller to
60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported") and
verified that reverting it solves the problem.

We have found issues in the past where Root Ports don't handle
extended tags correctly and have added quirks to avoid use of them:

  1b30dfd376e2 ("PCI: Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken")
  62ce94a7a5a5 ("PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken")

I don't know yet what Root Ports Robert has, but maybe we need a
similar quirk?

I'm pretty sure Root Ports that don't handle extended tags are out of
spec, so it would be ideal if we could get the manufacturer to provide
an erratum as documentation.

Bjorn
