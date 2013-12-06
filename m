Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:45807 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3LFAhr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 19:37:47 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so2375oag.4
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 16:37:46 -0800 (PST)
Subject: [PATCH v2 0/2] Remove ksets from sysfs eagerly
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Veaceslav Falico <vfalico@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Neil Horman <nhorman@tuxdriver.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>
Date: Thu, 05 Dec 2013 17:37:43 -0700
Message-ID: <20131206003508.28684.1337.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This removes ksets from sysfs immediately in kset_unregister() to help
prevent module unload/reload problems.  It also adds more variability
to the CONFIG_DEBUG_KOBJECT_RELEASE option by delaying release functions
for a somewhat random time, to change the order in which they can be
called.

---

Bjorn Helgaas (2):
      kobject: delay kobject release for random time
      kobject: remove kset from sysfs immediately in kset_unregister()


 Documentation/kobject.txt |    5 ++++-
 lib/kobject.c             |   11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)
