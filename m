Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
To: Khuong Dinh <kdinh@apm.com>, lorenzo.pieralisi@arm.com,
 marc.zyngier@arm.com, msalter@redhat.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <55d52fce-be87-f055-e19b-4122015d5c94@redhat.com>
Date: Fri, 28 Apr 2017 01:11:25 -0400
MIME-Version: 1.0
In-Reply-To: <1493340847-25720-1-git-send-email-kdinh@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rjw@rjwysocki.net, Duc Dang <dhdang@apm.com>, patches@apm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/27/2017 08:54 PM, Khuong Dinh wrote:
> From: Khuong Dinh <kdinh@apm.com>
> 
> This patch makes pci-xgene-msi driver ACPI-aware and provides
> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> 
> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks. Currently testing. Will review and followup shortly.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
