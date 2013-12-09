Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:54256 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab3LIUUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 15:20:08 -0500
MIME-Version: 1.0
In-Reply-To: <8833f61075af4c97895aadc42c3f7335@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
	<CABawtvPMSGc+7HqqtE9NXxCo11Vp-Yu+feF6UqS18k+jwPxoVw@mail.gmail.com>
	<c2a37fdd0e654fa3adccb0bcc38adb09@DM2PR05MB671.namprd05.prod.outlook.com>
	<CAE9FiQU7gM3gQkhWMXCTrJUqL137TW2TBL_gW=N2s3cbHr+5EA@mail.gmail.com>
	<8833f61075af4c97895aadc42c3f7335@DM2PR05MB671.namprd05.prod.outlook.com>
Date: Mon, 9 Dec 2013 12:20:07 -0800
Message-ID: <CAE9FiQXCpqFjCQhWCmK=pJGoef4nBRZtxJuufPSoG9OLjoKLNg@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Yinghai Lu <yinghai@kernel.org>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Ethan Zhao <ethan.kernel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 11:35 AM, Rajat Jain <rajatjain@juniper.net> wrote:

> Actually there are situations where the presence detect signal does not make much sense, because the card is not really plugged out physically. For e.g. how do we deal with PCIe end points that may be on the board itself, but say come out of reset after the bootup? Or go down during a firmware upgrade and again come back up after the upgrade?
>

That is driver's job.
mpt2sas driver does diag_reset.

Think about kernel that could even be compiled without pciehp built-in.

Yinghai
