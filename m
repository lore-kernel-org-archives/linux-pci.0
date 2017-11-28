Return-Path: <SRS0=09l/=C2=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=09l/=C2=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V2 7/7] PCI: make reset poll time adjustable
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Christoffer Dall <cdall@linaro.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Ding Tianhong
 <dingtianhong@huawei.com>, Michal Hocko <mhocko@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-8-git-send-email-okaya@codeaurora.org>
 <20171128142044.GC11228@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <837be7ee-13c7-8e8a-1a6b-87fd5e42b166@codeaurora.org>
Date: Tue, 28 Nov 2017 09:26:30 -0500
MIME-Version: 1.0
In-Reply-To: <20171128142044.GC11228@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/28/2017 9:20 AM, Bjorn Helgaas wrote:
>> Introduce pci=resetpolltime= argument to override 60 seconds poll time in
>> units of milliseconds.
> I resist adding kernel parameters because they really complicate the
> user experience.  Obviously you added this for a reason, but I don't
> know what that is.  If we really need it, is there any way we could
> automatically figure out in the kernel when we need different poll
> times?
> 

No, we can drop this patch if we want to . This was mostly a
scalability concern. 

I worried adding 60 seconds would be too much for some use case. We can
hold onto this change until that use case happens if you want.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
