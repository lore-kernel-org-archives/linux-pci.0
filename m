Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51791 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab3EaT0J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 15:26:09 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so5026718iee.41
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 12:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t8ODdHOz-ajwUBUv34XOH=i65S=4D0=HnvDLjCV7N3n8g@mail.gmail.com>
References: <CAH9N0t8ODdHOz-ajwUBUv34XOH=i65S=4D0=HnvDLjCV7N3n8g@mail.gmail.com>
Date: Fri, 31 May 2013 12:26:08 -0700
Message-ID: <CAE9FiQVZoybuq-ekQWUmXs8ggKmSdGo2zsLbxv7Shj3ZQAkiqw@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver Automatic Scripts
From: Yinghai Lu <yinghai@kernel.org>
To: Paulo Ricardo Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 10:35 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:

> Also, How can I perform an entire pcie express bus reset from linux terminal?

disable_pcie_link and reenable the pcie link?
