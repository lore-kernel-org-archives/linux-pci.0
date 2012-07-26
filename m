Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58841 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2GZRDa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 13:03:30 -0400
MIME-Version: 1.0
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Thu, 26 Jul 2012 20:03:09 +0300
Message-ID: <CAHzK-V0XpkVJHgqWiWpYP1jx5DPX=voE0eymK+5FG-zhrJOwAQ@mail.gmail.com>
Subject: Cabled PCIE device hotplug/hot-removal
To: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a  PCIe device connected with cables to a host (kernel 3.5.0-rc7+).
What are the handler I need to add to a driver in order to catch cable
pull-out / push-in?

The pcisig presentation
"http://www.pcisig.com/developers/main/training_materials/get_document?doc_id=f4ca40ec1721aa7fadd05e2903b0172c36656294"
talks about PERST# detection for cabled PCIe hotplug.

Does the kernel detect it?

None of the pci_driver or pci_error_handlers callbacks were called
when using powered down/up the device (electrically).

Thanks.

Shlomo Pongratz
