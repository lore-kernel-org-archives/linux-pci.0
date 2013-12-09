Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34115 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761260Ab3LIT2J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 14:28:09 -0500
MIME-Version: 1.0
In-Reply-To: <c2a37fdd0e654fa3adccb0bcc38adb09@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
	<CABawtvPMSGc+7HqqtE9NXxCo11Vp-Yu+feF6UqS18k+jwPxoVw@mail.gmail.com>
	<c2a37fdd0e654fa3adccb0bcc38adb09@DM2PR05MB671.namprd05.prod.outlook.com>
Date: Mon, 9 Dec 2013 11:28:08 -0800
Message-ID: <CAE9FiQU7gM3gQkhWMXCTrJUqL137TW2TBL_gW=N2s3cbHr+5EA@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Yinghai Lu <yinghai@kernel.org>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Ethan Zhao <ethan.kernel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 10:46 AM, Rajat Jain <rajatjain@juniper.net> wrote:
>
> This is for the systems that do not implement elements like attention button:

then your pcie slot should add Surprise Removal/Insert support in your HW?

Yinghai
