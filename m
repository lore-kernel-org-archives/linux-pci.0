Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0hOrY3iP8QQMQxkNtY7vQcrShQuPBxyNBqY6DYaxhf1bA@mail.gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Linux PCI <linux-pci@vger.kernel.org>, ravikanth.nalla@hpe.com,
	Len Brown <lenb@kernel.org>, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56C5F4B4.2080400@codeaurora.org>
Date: Thu, 18 Feb 2016 11:43:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hOrY3iP8QQMQxkNtY7vQcrShQuPBxyNBqY6DYaxhf1bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/18/2016 11:39 AM, Rafael J. Wysocki wrote:
>> +#define ACPI_PCI_LINK_MAX_EARLY_IRQINFO 1024
> Why do we need so many of them?
> 

The previous code supported 1024 max interrupts before 
"ACPI, PCI, irq: remove interrupt count restriction" change. 

I added back 1024 number but the limit is only for early IRQs now.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
