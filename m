Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Tai <thomas.tai@oracle.com>
To: bhelgaas@google.com, rostedt@goodmis.org, thomas.tai@oracle.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mr.nuke.me@gmail.com
Subject: [PATCH V2 0/1] PCI/AER: add pcie TLP header information in the tracepoint
Date: Tue,  8 May 2018 15:56:59 -0400
Message-Id: <1525809420-30576-1-git-send-email-thomas.tai@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and Steven,
Would you kindly review the patch for me? following are the
changes details. Please feel free to comment.

Change log since last version:
V2:
1. use u8 for boolean variable
2. check tlp_header_valid before accessing tlp_header
3. replace sizeof(unsigned int) with 4
4. change the variable name buf to tlp_header for better reading

Thank you,
Thomas
