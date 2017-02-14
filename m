Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: Xilinx NWL: Remove mask for messages not supported
 by AXI
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Bjorn Helgaas
 <helgaas@kernel.org>
References: <1485853170-31940-1-git-send-email-bharatku@xilinx.com>
 <20170210202536.GI29169@bhelgaas-glaptop.roam.corp.google.com>
 <8520D5D51A55D047800579B094147198263E9378@XAP-PVEXMBX02.xlnx.xilinx.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <1bbe7581-476b-b531-7173-cd56bc82bc66@xilinx.com>
Date: Tue, 14 Feb 2017 15:42:52 +0100
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198263E9378@XAP-PVEXMBX02.xlnx.xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 Ravikiran Gummaluri <rgummal@xilinx.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 14.2.2017 15:29, Bharat Kumar Gogada wrote:
>> On Tue, Jan 31, 2017 at 02:29:30PM +0530, Bharat Kumar Gogada wrote:
>>> - Removing support for vendor defined messages which are not
>>> suppoerted by AXI
>>>
>>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>>
>> Applied to pci/host-xilinx for v4.11, thanks.
>>
> Thanks Bjorn.
>> Bharat, get_maintainer.pl lists you as a contributor, but not as a maintainer of
>> this file.  Should we update MAINTAINERS so it does?
> Yes, Please update MAINTAINERS list.

I expect it is more about you to create a patch and send it to Bjorn.

Thanks,
Michal


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
