Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62362 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaLCCyE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Dec 2014 21:54:04 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so14827706pab.30
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2014 18:54:03 -0800 (PST)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAErSpo6U9Zpw1Dd79yFmEksEdHSmqDJe517JsLUSN79P9iEJRA@mail.gmail.com>
References: <CAHH3p5L5bX+9PfZCFHAYmyAS9+kg9CpdQWnAy7WZLCNBm+RYSA@mail.gmail.com>
	<CAErSpo6U9Zpw1Dd79yFmEksEdHSmqDJe517JsLUSN79P9iEJRA@mail.gmail.com>
Date: Tue, 2 Dec 2014 18:54:02 -0800
Message-ID: <CAA93t1rvKmF_cUwYi1+OqC3hPL0zVxKJxgLt0Qu4NsKh2ePQkw@mail.gmail.com>
Subject: Re: PCIE card link up w/ or w/o device connected
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: shiv prakash Agarwal <chhotu.shiv@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shiv,

On Tue, Dec 2, 2014 at 12:13 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Pratyush, Yinghai, Alex, Rajat]
>
> On Wed, Nov 26, 2014 at 7:57 AM, shiv prakash Agarwal
> <chhotu.shiv@gmail.com> wrote:
>> Hi All,
>>
>> Is anybody aware of any pcie card which gets detected by root port i.e
>> link is up only when any device is connected to card? For example:
>> PCIE USB3 card link is up only when a usb3 device is connected to it.
>>
>> Is it possible at least? Or card link will always be up whether any
>> device is connected to it or not?

Yes it is technically possible. It all depends on the logic of the
card, and when does it decide to bring up the PCIe link. In your case
apparently the card decides to bring up the PCIe link only when the
USB device is detected.

Thanks,

Rajat
