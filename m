Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] x86/PCI: Fix regression caused by commit 4d6b4e69a245
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>
References: <5655B392.7070701@intel.com> <8206751.4eTpiUuo7l@vostro.rjw.lan>
 <565BA446.7080003@linux.intel.com> <2099144.E7yRfeyfk4@vostro.rjw.lan>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Arthur Marsh <arthur.marsh@internode.on.net>
From: Hans de Bruin <jmdebruin@xmsnet.nl>
Message-ID: <565DEE62.9080105@xmsnet.nl>
Date: Tue, 1 Dec 2015 20:00:50 +0100
MIME-Version: 1.0
In-Reply-To: <2099144.E7yRfeyfk4@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/30/2015 03:11 AM, Rafael J. Wysocki wrote:
> On Monday, November 30, 2015 09:20:06 AM Jiang Liu wrote:
>> On 2015/11/28 0:06, Rafael J. Wysocki wrote:
...
>>
>> And I only refined the commit message based on the test patch
>> I sent to Authur as an attachment at Nov 25.
>
> OK, thanks.
>
> Keith, Hans, can you test this version too please?
>

This version of the patch works on my laptop too.

-- 
Hans

