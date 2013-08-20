Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:31931 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133Ab3HTA2B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2013 20:28:01 -0400
From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<dougthompson@xmission.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<jbeulich@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Subject: [PATCH 0/1] AMD64_EDAC: Fix incorrect wrap arounds due to left shift beyond 32 bits. 
Date: Mon, 19 Aug 2013 19:27:51 -0500
Message-ID: <1376958472-2150-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Aravind Gopalakrishnan (1):
  AMD64_EDAC: Fix incorrect wrap arounds due to left shift beyond 32
    bits.

 drivers/edac/amd64_edac.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.10.4


