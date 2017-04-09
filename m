Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35656 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdDIPyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Apr 2017 11:54:52 -0400
Received: by mail-yw0-f178.google.com with SMTP id d191so50698874ywe.2
        for <linux-pci@vger.kernel.org>; Sun, 09 Apr 2017 08:54:52 -0700 (PDT)
MIME-Version: 1.0
From: Kevin Wilson <wkevils@gmail.com>
Date: Sun, 9 Apr 2017 18:54:51 +0300
Message-ID: <CAGXs5wV_Q6NTg46Tbu0TMXwnigJOHOqiR-2zkBYaVezAcb3igQ@mail.gmail.com>
Subject: Serial info, Mac address in PCI configuration space, and missing
 interpratation of 2 bytes
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
When I am running (for a Mellanox Connectx-2 NIC):
lspci -vvv -s 0000:01:00.0 | grep  Serial
I get :

Capabilities: [148 v1] Device Serial Number 00-02-c9-03-00-57-b1-00

The MAC address of the device is 00-02-c9-57-b1-00; this is the output
of the above lspci command without the two
inner bytes of 03-00

I noticed that I get the same thing with other NIC devices from other
vendors(I mean that the the MAC address is the result excluding the
two inner bytes); but the values of the inner bytes differ. For
example, in a different case I got "ff ff" as the two inner bytes,

My question is: what does the "03-00" and "ff-ff" (and probably other
values for other  nics) mean  and how can I decipher them ?
And what is [148 v1]  which immediately follows: "Capabilities:" in
the output of the lspci above? in a different nic I got
140 and not 148, like this:"Capabilities: [140 v1]"

Regards,
Kevin
