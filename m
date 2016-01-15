Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Jan 2016 20:33:17 -0600
From: Rob Herring <robh@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: bhelgaas@google.com, michals@xilinx.com, lorenzo.pieralisi@arm.com,
	paul.burton@imgtec.com, yinghai@kernel.org, wangyijing@huawei.com,
	russell.joyce@york.ac.uk, sorenb@xilinx.com,
	jiang.liu@linux.intel.com, arnd@arndb.de, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V2 4/5] PCI: xilinx: Updating Zynq PCI binding
 documentation with  Microblaze node.
Message-ID: <20160115023317.GA1846@rob-hp-laptop>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-5-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452620173-4905-5-git-send-email-bharatku@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 12, 2016 at 11:06:12PM +0530, Bharat Kumar Gogada wrote:
> Updated Zynq PCI binding documentation with Microblaze node.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Changes:
> Adding Microblaze device tree node Documnetation.
> ---
>  .../devicetree/bindings/pci/xilinx-pcie.txt        | 36 ++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
