Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V8 2/5] PCI/ASPM: split pci_aspm_init() into two
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-3-git-send-email-okaya@codeaurora.org>
 <CACK8Z6EfUTDjCM=fmdHfWeu8UV5GN+i6PX9fKkR1H8K90TXozg@mail.gmail.com>
 <CAErSpo4gduGVq2Na0tYbG77Pi23R-RMBvAcJueWrQTJCRsHYGw@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <04c89a56-5e33-22e7-8665-cd94ac56d920@codeaurora.org>
Date: Fri, 14 Apr 2017 15:10:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4gduGVq2Na0tYbG77Pi23R-RMBvAcJueWrQTJCRsHYGw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, David Daney <david.daney@cavium.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Timur Tabi <timur@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 4/13/2017 2:25 PM, Bjorn Helgaas wrote:
> I agree, and I made that change on my branch.  I also renamed these to
> pci_aspm_init_downstream_port() (for Root Ports and Switch Downstream
> Ports) and pci_aspm_init_upstream_port() (for Switch Upstream Ports
> and Endpoints) to try to match the terminology in the spec.

OK. I reordered and renamed the functions according to your suggestions
on my local copy too.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
