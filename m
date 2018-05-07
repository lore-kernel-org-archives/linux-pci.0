Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@codeaurora.org>, <mr.nuke.me@gmail.com>
Subject: Re: AER: Malformed TLP recovery deadlock with NVMe drives
Date: Mon, 7 May 2018 23:57:40 +0000
Message-ID: <3d4991bc2948430d910a16da36c90b91@ausx13mps321.AMER.DELL.COM>
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
 <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>
 <9fc90040d5712282ea223807ace39312@codeaurora.org>
 <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
 <16bdb0febb842ad0980db9214c8076c5@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Shyam.Iyer@dell.com, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, keith.busch@intel.com, Austin.Bolen@dell.com,
 linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 5/7/2018 5:46 PM, okaya@codeaurora.org wrote:
[snip]
>> If it were easy, somebody would have patched it by now ;)
> 
> Can you file a bugzilla CC me, keith and bjorn and attach all of your
> logs?

Sure. Which bugzilla?


> Let's debug this there.

Debugging over email not fun enough?

Alex


>>> With this patch, you shouldn't
>>> see link down and up interrupts during reset but i do see them in the
>>> log.
>>
>> You will see the messages from the link up/down events regardless if
>> any
>> action is actually taken.
>>
>>> Can you also share a fail case log with this patch and a diff of your
>>> hacks so that we know where prints are coming from.
>>
>> Of course. Example of failing case [3], and is identical to the fail
>> log
>> without any patches. Although prints have the function name, the diff
>> is
>> in [4].
>>
>> Alex
>>
>> [3] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1509.log
>> [4] http://gtech.myftp.org/~mrnuke/nvme_logs/print_hacks.patch
>>
>>
>>>> [2] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1429.log
>>>>>> [1] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1308.log
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
