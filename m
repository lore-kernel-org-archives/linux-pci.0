Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150109174652.GE6575@google.com>
References: <1417763857-11993-1-git-send-email-chuansheng.liu@intel.com>
	<Pine.LNX.4.44L0.1412051415180.13167-100000@ida.rowland.org>
	<20150109174652.GE6575@google.com>
Date: Mon, 11 May 2015 14:58:58 +0800
Message-ID: <CAOzJMDSagkZWiMMWFW1y23EtmdhMp1pUobwMXZvf0BpLUqxbeA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add disabling pm async quirk for JMicron chips
From: Aaron Lu <aaron.lu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	mister.freeman@laposte.net, Tejun Heo <tj@kernel.org>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	Linux-pm mailing list <linux-pm@vger.kernel.org>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 10, 2015 at 1:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Dec 05, 2014 at 02:18:40PM -0500, Alan Stern wrote:
>> On Fri, 5 Dec 2014, Chuansheng Liu wrote:
>>
>> You know, this is exactly why device_pm_wait_for_dev() exists -- so
>> that asynchronous power-management operations can wait for other
>> devices even when there's no parent-child relation.
>>
>> You should try to use device_pm_wait_for_dev() instead of disabling
>> async suspend/resume.
>
> Dropping this patch for now, waiting for a response to Alan's suggestion.

>From Alan's comments #106:
https://bugzilla.kernel.org/show_bug.cgi?id=81551#c106

It seems Chuansheng's patch is the best solution for now, so perhaps
it can be considered to be merged?

Regards,
Aaron
