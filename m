Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:19327
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751272AbeAAXvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jan 2018 18:51:20 -0500
To: <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From: Max Gurtovoy <maxg@mellanox.com>
Subject: pci driver loads right after unload
Message-ID: <13c000eb-5fbe-1787-54c0-d113500cf3db@mellanox.com>
Date: Tue, 2 Jan 2018 01:50:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1255"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi all,
I encountered a strange phenomena using 2 different pci drivers (nvme 
and mlx5_core) since 4.15-rc1:
when I try to unload the modules using "modprobe -r" cmd it calls the 
.probe function right after calling the .remove function and the module 
is not realy unloaded.
I think there is some race condition because when I added a msleep(1000) 
after "pci_unregister_driver(&nvme_driver);" (in the nvme module 
testing, it also worked in the mlx5_core), the issue seems to dissapear.

any thoughts or idea what is causing this behaviour ?

-Max.
