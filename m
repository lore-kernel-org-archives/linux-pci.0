Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59788 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2JLFfs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2012 01:35:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2496249pad.19
        for <linux-pci@vger.kernel.org>; Thu, 11 Oct 2012 22:35:47 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: MPS patches 
Date: Thu, 11 Oct 2012 22:35:52 -0700
Message-Id: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,
Patch 1/3 is a resend that appears to have not been included in your
  tree (http://permalink.gmane.org/gmane.linux.kernel.pci/16627)
Patch 2/3 is a comment error that Don Dutile noticed in the original 
  submission of the previous patch
Patch 3/3 is a new patch that provides a more sane default for the MPS
  detection.  While I still believe we should have the MPS 
  detection/modification "on" by default, this provides a good default.
  And, hopefully, it will help find issues with MPS-hardware via users
  self-selecting to test it.

Thanks,
Jon

