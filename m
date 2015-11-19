Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34473 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932761AbbKSP4a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Nov 2015 10:56:30 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B925420681
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2015 15:56:29 +0000 (UTC)
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 0B09B20676
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2015 15:56:29 +0000 (UTC)
Received: by obdgf3 with SMTP id gf3so63996804obd.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2015 07:56:28 -0800 (PST)
MIME-Version: 1.0
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 19 Nov 2015 07:56:08 -0800
Message-ID: <CALCETrV-S64Vi=QLhGNe_LZ78uPp-OhcZ8nM2KjDFn8+346=Nw@mail.gmail.com>
Subject: i2c_designware doesn't recover from subdevice driver unload
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I unloaded and reloaded hid_multitouch (on a Skylake laptop where the
HID device is behind an integrated designware controller) and I got:

[39545.054684] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[39545.061728] i2c_designware i2c_designware.1:
i2c_dw_handle_tx_abort: lost arbitration
[39545.061734] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[39545.061944] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[39545.062373] i2c_hid i2c-DLL0704:01: error in i2c_hid_init_report
size:6 / ret_size:4
[39545.062564] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[39545.062636] input: DLL0704:01 06CB:76AE UNKNOWN as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL0704:01/0018:06CB:76AE.0005/input/input20
[39545.063212] hid-multitouch 0018:06CB:76AE.0005: input,hidraw1:
<UNKNOWN> HID v1.00 Mouse [DLL0704:01 06CB:76AE] on
[40178.534814] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[40178.541848] i2c_designware i2c_designware.1:
i2c_dw_handle_tx_abort: lost arbitration
[40178.541853] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[40179.542135] i2c_designware i2c_designware.1: controller timed out
[40179.542166] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[40180.542909] i2c_designware i2c_designware.1: controller timed out
[40180.542942] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
[40181.543697] i2c_designware i2c_designware.1: controller timed out

after that, I just keep seeing "controller timed out" messages.

This is Linux 4.3.0.

--Andy
