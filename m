Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64764 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab1L1Dp1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2011 22:45:27 -0500
Received: by vcbfk14 with SMTP id fk14so9287300vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 27 Dec 2011 19:45:26 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 28 Dec 2011 11:45:26 +0800
Message-ID: <CAEH94LjSjBvXYABrh+W7kcp3z3h5JyFqsZpNv0zB0v1XZZ1+cQ@mail.gmail.com>
Subject: PCI: where pci_user_read_config_byte{word, dword}() is defined?
From: Zhi Yong Wu <zwu.kernel@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HI,

I want to take a look at how pci_user_read_config_byte{word, dword}()
is implemented, but can not find their definitions. Can anyone let me
know where their definitions locate?


-- 
Regards,

Zhi Yong Wu
