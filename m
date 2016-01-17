Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38629 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcAQPfe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jan 2016 10:35:34 -0500
Received: by mail-wm0-f42.google.com with SMTP id b14so89137406wmb.1
        for <linux-pci@vger.kernel.org>; Sun, 17 Jan 2016 07:35:33 -0800 (PST)
Received: from ?IPv6:2001:a61:309b:3c01:cd4b:13cc:6eb6:80ab? ([2001:a61:309b:3c01:cd4b:13cc:6eb6:80ab])
        by smtp.gmail.com with ESMTPSA id e9sm19702839wjp.18.2016.01.17.07.35.31
        for <linux-pci@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jan 2016 07:35:32 -0800 (PST)
To: linux-pci@vger.kernel.org
From: Xavier Gnata <xavier.gnata@gmail.com>
Subject: ID conflict between bdc_pci and "720p FaceTime HD Camera"
Message-ID: <569BB4C2.3020602@gmail.com>
Date: Sun, 17 Jan 2016 16:35:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

The development of a driver for
02:00.0 Multimedia controller [0480]: Broadcom Corporation 720p FaceTime 
HD Camera [14e4:1570]
has started. It is still in an early stage but it's progressing and it 
already streams.
https://github.com/patjak/bcwc_pcie

However, as you can see, this webcam shares the exact same ID as bdc_pci 
0x1570 .

Could we use e.g. PCI_CLASS in bdc_pci to avoid grabbing the webcam 
incorrectly?
The FaceTime HD Camera has PCI_CLASS 0x048000
I hope that bdc_pci has another PCI_CLASS.
Or maybe there is a better way to distinguish bdc_pci from FaceTime HD 
Camera. What do you think?

Regards,
Xavier
