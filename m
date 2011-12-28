Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33030 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab1L1EzA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2011 23:55:00 -0500
Message-ID: <4EFAA11F.8060007@windriver.com>
Date: Wed, 28 Dec 2011 12:54:55 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Zhi Yong Wu <zwu.kernel@gmail.com>
CC: <linux-pci@vger.kernel.org>, Ram Pai <linuxram@us.ibm.com>
Subject: Re: PCI: where pci_user_read_config_byte{word, dword}() is defined?
References: <CAEH94LjSjBvXYABrh+W7kcp3z3h5JyFqsZpNv0zB0v1XZZ1+cQ@mail.gmail.com>
In-Reply-To: <CAEH94LjSjBvXYABrh+W7kcp3z3h5JyFqsZpNv0zB0v1XZZ1+cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Zhi Yong Wu wrote:
> HI,
> 
> I want to take a look at how pci_user_read_config_byte{word, dword}()
> is implemented, but can not find their definitions. Can anyone let me
> know where their definitions locate?

Refer to drivers/pci/access.c.

Tiejun
