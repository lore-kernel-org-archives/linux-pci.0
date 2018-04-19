Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbeDSUQV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 16:16:21 -0400
Subject: [PATCH 0/4] lspci: Decode capability names
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Thu, 19 Apr 2018 15:16:19 -0500
Message-ID: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a minor update to print the names of several capabilities instead
of just the hex capability ID.

I'd love it if somebody would implement decoding of the content of these
capabilities, but I haven't had time to do that.

---

Bjorn Helgaas (4):
      lspci: Clarify unknown capability IDs
      lspci: Decode Null Capability
      lspci: Print names of capabilities even if we can't decode the rest
      lspci: Use spec name for RCRB ((Root Complex Register Block)


 lib/header.h |   21 ++++++++++++++++++++-
 ls-caps.c    |    5 ++++-
 ls-ecaps.c   |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 78 insertions(+), 5 deletions(-)
