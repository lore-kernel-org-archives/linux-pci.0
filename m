Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
 <20171122075345.GC26583@kroah.com>
 <81de37c1-26b5-41f7-ab32-b98012890971@codeaurora.org>
 <20171122164546.GB30812@kroah.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3cca8693-72bf-db72-f698-f111c9ef707c@codeaurora.org>
Date: Wed, 22 Nov 2017 11:50:53 -0500
MIME-Version: 1.0
In-Reply-To: <20171122164546.GB30812@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 11:45 AM, Greg Kroah-Hartman wrote:
>> Funny thing is nobody is calling this function. Maybe, I should just kill it
>> instead.
> Yes, delete it.  Why doesn't the build warn about it not being used?
> 

OK. Because it is in a header file that nobody includes.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
