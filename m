Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: AER: Malformed TLP recovery deadlock with NVMe drives
To: "Alex G." <mr.nuke.me@gmail.com>
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
 <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>
 <9fc90040d5712282ea223807ace39312@codeaurora.org>
 <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d7b9b374-bb5f-7c84-af0f-08b8c7399f05@codeaurora.org>
Date: Mon, 7 May 2018 22:48:33 +0100
MIME-Version: 1.0
In-Reply-To: <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
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

On 5/7/2018 9:58 PM, Alex G. wrote:
>> Sounds like there are multiple problems.
> If it were easy, somebody would have patched it by now ;)
> 

I know...

Keith has been debugging similar problems recently. I also have interest
in error cases for hotplug. I have been keeping an eye on this for a while
to see what might be happening.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
