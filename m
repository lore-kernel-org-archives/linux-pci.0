Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:38270 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781AbaB0GCA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 01:02:00 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <bhelgaas@google.com>
Cc: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	<spear-devel@list.st.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH V2 0/2] PCI: dessignware: fixes and cleanup
Date: Thu, 27 Feb 2014 11:31:26 +0530
Message-ID: <cover.1392904207.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset fixes iATU programming sequence and correct some comments.

Changes ssince v1:
	- Change ssubject line with proper spacing 

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: spear-devel@list.st.com
Cc: linux-pci@vger.kernel.org

Mohit Kumar (2):
  PCI: designware: Fix comment for setting number of lanes
  PCI: designware: Fix iATU programming for cfg1, io and mem viewport

 drivers/pci/host/pcie-designware.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.3.4

