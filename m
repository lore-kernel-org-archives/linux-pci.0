Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:48957 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab3LIA6O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2013 19:58:14 -0500
MIME-Version: 1.0
In-Reply-To: <aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
Date: Sun, 8 Dec 2013 16:58:13 -0800
Message-ID: <CAE9FiQUBERP_Mtv1V0R6LNrsGLr81bamXV1tSAArwTAqa1qxSA@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Yinghai Lu <yinghai@kernel.org>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 8, 2013 at 1:29 PM, Rajat Jain <rajatjain@juniper.net> wrote:
>
> In fact things do get more complicated if we introduce link state based hot-plug, because then that requires that we do NOT disable the link permanently during power off. (Because we would want to receive future hot-plug link-up events).

is that out of spec?

Why do we need to use link state event with hotplug? What is attention
button doing?

Yinghai
