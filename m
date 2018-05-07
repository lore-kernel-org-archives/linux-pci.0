Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: AER: Malformed TLP recovery deadlock with NVMe drives
To: okaya@codeaurora.org
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
 <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>
 <9fc90040d5712282ea223807ace39312@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
Date: Mon, 7 May 2018 15:58:22 -0500
MIME-Version: 1.0
In-Reply-To: <9fc90040d5712282ea223807ace39312@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Alex_Gagniuc@dellteam.com, linux-pci@vger.kernel.org, shyam_iyer@dell.com,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 austin_bolen@dell.com, linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 05/07/2018 03:30 PM, okaya@codeaurora.org wrote:
> On 2018-05-07 21:16, Alex G. wrote:
>> On 05/07/2018 01:46 PM, okaya@codeaurora.org wrote:
>>> On 2018-05-07 19:36, Alex G. wrote:
>>>> Hi! Me again!
>>>>
>>>> I'm seeing what appears to be a deadlock in the AER recovery path. It
>>>> seems that the device_lock() call in report_slot_reset() never returns.
>>>> How we get there is interesting:
>>>
>>> Can you give this patch a try?
>>>
>> Oh! Patches so soon? Yay!
>>
>>> https://patchwork.kernel.org/patch/10351515/
>>
>> Thank you! I tried a few runs. there was one run where we didn't lock
>> up, but the other runs all went like before.
>>
>> For comparison, the run that didn't deadlock looked like [2].
>>
> 
> 
> Sounds like there are multiple problems.

If it were easy, somebody would have patched it by now ;)

> With this patch, you shouldn't
> see link down and up interrupts during reset but i do see them in the log.

You will see the messages from the link up/down events regardless if any
action is actually taken.

> Can you also share a fail case log with this patch and a diff of your
> hacks so that we know where prints are coming from.

Of course. Example of failing case [3], and is identical to the fail log
without any patches. Although prints have the function name, the diff is
in [4].

Alex

[3] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1509.log
[4] http://gtech.myftp.org/~mrnuke/nvme_logs/print_hacks.patch


>> [2] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1429.log
>>>> [1] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1308.log

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
