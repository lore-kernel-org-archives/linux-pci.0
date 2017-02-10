Return-Path: <SRS0=Jwxw=ZX=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=Jwxw=ZX=gmail.com=valmikibow@kernel.org>
MIME-Version: 1.0
From: Valmiki Saleem <valmikibow@gmail.com>
Date: Fri, 10 Feb 2017 11:37:39 +0530
Message-ID: <CAHMCJGbrCxqA8CNT8q+U+y7q03+gFjir1X5dN9Yj+_TJeM5yGA@mail.gmail.com>
Subject: Can EP bars be called as device memory ?
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, helgaas@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi,

In ARMv8 TRM:
An unaligned access to any type of Device memory causes an Alignment fault.

What is meant by device memory ?
Can we call PCIe BAR memory on End point cards as device memory ?

Thanks,
valmiki
