Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tyler Baicar <tbaicar@codeaurora.org>
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        matt.fleming@intel.com, paul.gortmaker@windriver.com, bp@suse.de,
        zjzhang@codeaurora.org, sudipm.mukherjee@gmail.com, axboe@fb.com,
        izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH 0/2] Correct AER severity for printing AER information
Date: Mon, 12 Sep 2016 14:57:23 -0600
Message-Id: <1473713845-23613-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AER severity handling has two issues that cause the AER information to
be printed incorrectly. The first issue is that the function to calculate
the AER severity is called twice in the code path to print the AER
information. The second issue is that the original call to calculate the
AER severity expects the CPER severity but is recieving the GHES
severity.

Tyler Baicar (2):
  PCI/AER: Remove duplicate AER severity translation
  acpi: apei: send correct severity to calculate AER severity

 drivers/acpi/apei/ghes.c               | 2 +-
 drivers/pci/pcie/aer/aerdrv_errprint.c | 6 ++----
 include/linux/aer.h                    | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

