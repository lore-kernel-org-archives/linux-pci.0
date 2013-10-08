Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f172.google.com ([209.85.161.172]:61512 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab3JHUUa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 16:20:30 -0400
Received: by mail-gg0-f172.google.com with SMTP id a5so1565779ggn.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2013 13:20:29 -0700 (PDT)
Subject: [PATCH 2/2] kobject: fix kset sample error path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Veaceslav Falico <vfalico@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Neil Horman <nhorman@tuxdriver.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>
Date: Tue, 08 Oct 2013 14:20:24 -0600
Message-ID: <20131008202024.19377.25396.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131008201915.19377.34185.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131008201915.19377.34185.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, example_init() leaked a kset if any of the object creations
failed.  This fixes the leak by calling kset_unregister() in the error
path.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 samples/kobject/kset-example.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index d0c687f..5dce351 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -262,6 +262,7 @@ baz_error:
 bar_error:
 	destroy_foo_obj(foo_obj);
 foo_error:
+	kset_unregister(example_kset);
 	return -EINVAL;
 }
 

