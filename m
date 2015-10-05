Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33238 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbJEGDq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2015 02:03:46 -0400
MIME-Version: 1.0
Date: Mon, 5 Oct 2015 08:03:45 +0200
Message-ID: <CAKsTQnnuRzWjTtjLSt2FhPuy7s6V=oO5R7WKC0G4=VnR5s_AfQ@mail.gmail.com>
Subject: Which PCI development git repo to use?
From: Ruud <netwerkforens@gmail.com>
To: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

Looking at the changes in this sundays rc, it seems the PCI patches of
Yinghai do not get picked up in RC2 and later. I did see some patches
from helgaas.

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git

Does someone know the plans with regard to PCIe support for big
systems with problematic bioses (aka high density GPU computing
clusters) in the linus tree. Or is it just too much of a risk to
migrate to new PCIe configuration code as most users do not need it?

If the latter is the case, it is at least good to know now beforehand...

Best regards,

Ruud
