Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:46562 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbaDCPI3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 11:08:29 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so2050481obc.21
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 08:08:28 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 3 Apr 2014 20:38:28 +0530
Message-ID: <CAHH3p5LwsWqtK_RhaYNKi_HeNYH3EHrgXV21SbRTA4mm2Vyjwg@mail.gmail.com>
Subject: Writing to BARs of PCIE device
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I have a stress test which write a specific 4B pattern to whole BAR
space for all BARs of a pcie device.

Query is:

1. Is it allowed? Or will it have any side-effects?
2. If No, is it not allowed for all BARs or some BARs only like BAR0?
