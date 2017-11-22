Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 23/30] [media] atomisp: deprecate pci_get_bus_and_slot()
To: Alan Cox <alan@linux.intel.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-24-git-send-email-okaya@codeaurora.org>
 <1511353247.3539.10.camel@linux.intel.com>
 <b87604f8-07f5-5cdc-b022-286c17ea66eb@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <be055774-b9b8-3a7a-8894-f9f8faebe3b5@codeaurora.org>
Date: Wed, 22 Nov 2017 09:06:15 -0500
MIME-Version: 1.0
In-Reply-To: <b87604f8-07f5-5cdc-b022-286c17ea66eb@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 kbuild test robot <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>, linux-arm-msm@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 open list <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Avraham Shukron <avraham.shukron@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "open list:MEDIA INPUT INFRASTRUCTURE \(V4L/DVB\)"
 <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 9:05 AM, Sinan Kaya wrote:
> Hi Alex,

I tried to mean Alan. Sorry about that. 

Apparently, I didn't have enough coffee this morning. I shouldn't touch the
code for a few hours.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
