Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204132118.22074.rjw@sisk.pl>
Message-ID: <1334346546.93033.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Date: Fri, 13 Apr 2012 12:49:06 -0700 (PDT)
From: Mikko Vinni <mmvinni@yahoo.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Allen Kay <allen.m.kay@intel.com>,
	Jean Guyader <jean.guyader@eu.citrix.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <201204132118.22074.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki:

> On Friday, April 13, 2012, Mikko Vinni wrote:
>>  Bug report:
>>     https://bugzilla.kernel.org/show_bug.cgi?id=43099
>> 
>>  Briefly:
>> 
>>  After s2ram the touchpad on a HP dv5 laptop doesn't work anymore.
>> 
>>  dmesg contains this about the touchpad
>>  Apr 11 18:00:05 koni kernel: i8042: Can't write CTR while closing AUX 
> port
>>  Apr 11 18:00:08 koni kernel: i8042: Can't reactivate AUX port
>> 
>> 
>>  Full log in bugzilla with PCI and i8042 debug turned on.
>> 
>>  Bisected to:
>> 
>>  commit 26f41062f28de65e11d3cf353e52d0be73442be1
>>  Author: Kay, Allen M <allen.m.kay@intel.com>
>>  Date:   Thu Jan 26 10:25:53 2012 -0800
>> 
>>      PCI: check for pci bar restore completion and retry
>>     
>>      On some OEM systems, pci_restore_state() is called while FLR has not 
> yet
>>      completed.  As a result, PCI BAR register restore is not successful.  
> This fix
>>      reads back the restored value and compares it with saved value and 
> re-tries 10
>>      times before giving up.
> 
> Does reverting the above commit on top of the current Linus' tree fix the
> problem for you?


It does (at least with the tree from yesterday, 4166fb64593514ad920b7dbd290e0a934b37d24a).


Mikko

> 
> Rafael
> 
