Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Khuong Dinh <kdinh@apm.com>, lorenzo.pieralisi@arm.com,
 marc.zyngier@arm.com, msalter@redhat.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
 <55d52fce-be87-f055-e19b-4122015d5c94@redhat.com>
 <3167d9b9-e8e5-d6bf-1b82-3d19f218bad6@jonmasters.org>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <5dd7918f-c780-9a5d-1eb9-30c70f516db0@jonmasters.org>
Date: Thu, 4 May 2017 19:24:03 -0400
MIME-Version: 1.0
In-Reply-To: <3167d9b9-e8e5-d6bf-1b82-3d19f218bad6@jonmasters.org>
Subject: Re: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: patches@apm.com, Duc Dang <dhdang@apm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/28/2017 12:36 PM, Jon Masters wrote:
> On 04/28/2017 01:11 AM, Jon Masters wrote:
>> On 04/27/2017 08:54 PM, Khuong Dinh wrote:
>>> From: Khuong Dinh <kdinh@apm.com>
>>>
>>> This patch makes pci-xgene-msi driver ACPI-aware and provides
>>> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
>>>
>>> Signed-off-by: Khuong Dinh <kdinh@apm.com>
>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Thanks. Currently testing. Will review and followup shortly.
> 
> Attaching boot logs before and after. I tested with an Intel e1000.
> Before the patch I get fallback interrupts. Afterward, I get X-Gene MSI
> interrupts working. Please followup with answers to Marc's question
> about how you propose to guarantee boottime ordering of binding.

Any word?

Jon.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
