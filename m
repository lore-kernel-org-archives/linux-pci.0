Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51755 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbaBSO5s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 09:57:48 -0500
Received: by mail-ig0-f180.google.com with SMTP id m12so1370626iga.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 06:57:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAD6G_RRUjWLYkzR_=EFwO_tx1aJOqqn-jqixhj4tnnqpamv92g@mail.gmail.com>
References: <CAD6G_RRUjWLYkzR_=EFwO_tx1aJOqqn-jqixhj4tnnqpamv92g@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Feb 2014 07:57:28 -0700
Message-ID: <CAErSpo6_kXR_GWbK8SjOTVXYTZWEtMoH3FBww2Vn4He6TcuYEA@mail.gmail.com>
Subject: Re: pci_reset_bus() usage in rc drivers
To: Jagan Teki <jagannadh.teki@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 5:52 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi Bjorn,
>
> One of the functionality of pci_reset_bus could reset the secondary bus
> as described in the configuration space - pci_reset_bridge_secondary_bus()
>
> Does this reset require in the part of enumeration, what is usage of
> this in root complex
> driver perspective.

Sorry, I don't understand this last sentence.
