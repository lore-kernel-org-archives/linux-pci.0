Return-Path: <SRS0=Zh8q=GC=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Zh8q=GC=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
Date: Sun, 11 Mar 2018 23:03:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:

> That difference has been there since the beginning of DPC, so it has
> nothing to do with *this* series EXCEPT for the fact that it really
> complicates the logic you're adding to reset_link() and
> broadcast_error_message().
> 
> We ought to be able to simplify that somehow because the only real
> difference between AER and DPC should be that DPC automatically
> disables the link and AER does it in software.

I agree this should be possible. Code execution path should be almost
identical to fatal error case.

Is there any reason why you went to stop driver path, Keith?

Was it the absence of error callback? or are we missing something in our
assumptions?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
