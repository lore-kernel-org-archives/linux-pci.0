Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5591560A.8080107@linux.intel.com>
Date: Mon, 29 Jun 2015 22:28:26 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Boszormenyi Zoltan <zboszor@pr.hu>, Ingo Molnar <mingo@kernel.org>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Bugfix v3] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32-bit kernel
References: <20150624094916.GA5696@gmail.com> <1435141065-28536-1-git-send-email-jiang.liu@linux.intel.com> <20150624101843.GA8924@gmail.com> <559107F2.3080701@pr.hu>
In-Reply-To: <559107F2.3080701@pr.hu>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/29 16:55, Boszormenyi Zoltan wrote:
> 2015-06-24 12:18 keltezéssel, Ingo Molnar írta:
>> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
>>
>> Also note the indentation, that helps readability.
>>
>> Thanks,
>>
>> 	Ingo
> 
> So, will there be a v4 with a commit message satisfactory to Ingo
> that will be part of 4.0.7/4.1.1 and 4.2?

Hi Zoltan,
	I'm waiting for a few days to see if there will be other
comments, and will send out v4 then.
Thanks!
Gerry
