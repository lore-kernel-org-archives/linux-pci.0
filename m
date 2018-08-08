Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:56802
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbeHHQnm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Aug 2018 12:43:42 -0400
Subject: Re: [PATCH v6 8/9] net/mlx5: Do not call pcie_print_link_status()
To: Leon Romanovsky <leon@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com, Saeed Mahameed <saeedm@mellanox.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-8-mr.nuke.me@gmail.com>
 <20180808060848.GQ13378@mtr-leonro.mtl.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <05056a70-ee78-ea3c-0b9b-6d64a8663b11@mellanox.com>
Date: Wed, 8 Aug 2018 17:23:12 +0300
MIME-Version: 1.0
In-Reply-To: <20180808060848.GQ13378@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/8/2018 9:08 AM, Leon Romanovsky wrote:
> On Mon, Aug 06, 2018 at 06:25:42PM -0500, Alexandru Gagniuc wrote:
>> This is now done by the PCI core to warn of sub-optimal bandwidth.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> 

Alex,
I loaded mlx5 driver with and without these series. The report in dmesg 
is now missing. From what I understood, the status should be reported at 
least once, even if everything is in order. We need this functionality 
to stay.

net-next (dmesg output for 07:00.0):
[270498.625351] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
[270498.632130] mlx5_core 0000:07:00.0: 63.008 Gb/s available PCIe 
bandwidth (8 GT/s x8 link)
[270499.169533] (0000:07:00.0): E-Switch: Total vports 9, per vport: max 
uc(1024) max mc(16384)
[270499.182358] mlx5_core 0000:07:00.0: Port module event: module 0, 
Cable plugged

net-next + patches (dmesg output for 07:00.0):
[  331.608472] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
[  332.564938] (0000:07:00.0): E-Switch: Total vports 9, per vport: max 
uc(1024) max mc(16384)
[  332.616271] mlx5_core 0000:07:00.0: Port module event: module 0, 
Cable plugged
