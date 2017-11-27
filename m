Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511320389.6989.44.camel@perches.com>
References: <20171121225945.29377-1-colin.king@canonical.com> <1511320389.6989.44.camel@perches.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 11:08:54 -0500
Message-ID: <CAPoiz9zg4yrcgHxYYe+k_ADxgTx1HNkDj79sWiEQVs7vuw+Z5A@mail.gmail.com>
Subject: Re: [PATCH] NTB: switchtec_ntb: fix spelling mistake: "peforming" -> "performing"
To: Joe Perches <joe@perches.com>
Cc: Colin King <colin.king@canonical.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 21, 2017 at 10:13 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2017-11-21 at 22:59 +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in dev_err error message
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> index afe8ed6f3b23..d46d113210b5 100644
>> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> @@ -172,7 +172,7 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
>>
>>       if (ps == status) {
>>               dev_err(&sndev->stdev->dev,
>> -                     "Timed out while peforming %s (%d). (%08x)",
>> +                     "Timed out while performing %s (%d). (%08x)",
>
> probably nicer to add the missing newlines too.

Since you did all the work of this, I added it as a separate patch on
top of the previous commit and applied it to my ntb-next branch.  If
this isn't acceptable, scream now and I'll revert it.

Thanks,
Jon

> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 42 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index afe8ed6f3b23..e828ae279517 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -172,7 +172,7 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
>
>         if (ps == status) {
>                 dev_err(&sndev->stdev->dev,
> -                       "Timed out while peforming %s (%d). (%08x)",
> +                       "Timed out while performing %s (%d). (%08x)\n",
>                         op_text[op], op,
>                         ioread32(&ctl->partition_status));
>
> @@ -306,7 +306,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>         if (pidx != NTB_DEF_PEER_IDX)
>                 return -EINVAL;
>
> -       dev_dbg(&sndev->stdev->dev, "MW %d: part %d addr %pad size %pap",
> +       dev_dbg(&sndev->stdev->dev, "MW %d: part %d addr %pad size %pap\n",
>                 widx, pidx, &addr, &size);
>
>         if (widx >= switchtec_ntb_mw_count(ntb, pidx))
> @@ -337,7 +337,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>
>         if (rc == -EIO) {
>                 dev_err(&sndev->stdev->dev,
> -                       "Hardware reported an error configuring mw %d: %08x",
> +                       "Hardware reported an error configuring mw %d: %08x\n",
>                         widx, ioread32(&ctl->bar_error));
>
>                 if (widx < nr_direct_mw)
> @@ -491,7 +491,7 @@ static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
>         if (link_sta != old) {
>                 switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_CHECK_LINK);
>                 ntb_link_event(&sndev->ntb);
> -               dev_info(&sndev->stdev->dev, "ntb link %s",
> +               dev_info(&sndev->stdev->dev, "ntb link %s\n",
>                          link_sta ? "up" : "down");
>         }
>  }
> @@ -523,7 +523,7 @@ static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
>  {
>         struct switchtec_ntb *sndev = ntb_sndev(ntb);
>
> -       dev_dbg(&sndev->stdev->dev, "enabling link");
> +       dev_dbg(&sndev->stdev->dev, "enabling link\n");
>
>         sndev->self_shared->link_sta = 1;
>         switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
> @@ -537,7 +537,7 @@ static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
>  {
>         struct switchtec_ntb *sndev = ntb_sndev(ntb);
>
> -       dev_dbg(&sndev->stdev->dev, "disabling link");
> +       dev_dbg(&sndev->stdev->dev, "disabling link\n");
>
>         sndev->self_shared->link_sta = 0;
>         switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
> @@ -792,7 +792,7 @@ static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
>         part_map &= ~(1 << sndev->self_partition);
>         sndev->peer_partition = ffs(part_map) - 1;
>
> -       dev_dbg(&sndev->stdev->dev, "Partition ID %d of %d (%llx)",
> +       dev_dbg(&sndev->stdev->dev, "Partition ID %d of %d (%llx)\n",
>                 sndev->self_partition, sndev->stdev->partition_count,
>                 part_map);
>
> @@ -829,7 +829,7 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
>         sndev->nr_lut_mw = ioread16(&sndev->mmio_self_ctrl->lut_table_entries);
>         sndev->nr_lut_mw = rounddown_pow_of_two(sndev->nr_lut_mw);
>
> -       dev_dbg(&sndev->stdev->dev, "MWs: %d direct, %d lut",
> +       dev_dbg(&sndev->stdev->dev, "MWs: %d direct, %d lut\n",
>                 sndev->nr_direct_mw, sndev->nr_lut_mw);
>
>         sndev->peer_nr_direct_mw = map_bars(sndev->peer_direct_mw_to_bar,
> @@ -839,7 +839,7 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
>                 ioread16(&sndev->mmio_peer_ctrl->lut_table_entries);
>         sndev->peer_nr_lut_mw = rounddown_pow_of_two(sndev->peer_nr_lut_mw);
>
> -       dev_dbg(&sndev->stdev->dev, "Peer MWs: %d direct, %d lut",
> +       dev_dbg(&sndev->stdev->dev, "Peer MWs: %d direct, %d lut\n",
>                 sndev->peer_nr_direct_mw, sndev->peer_nr_lut_mw);
>
>  }
> @@ -897,7 +897,7 @@ static int switchtec_ntb_init_req_id_table(struct switchtec_ntb *sndev)
>
>         if (ioread32(&sndev->mmio_self_ctrl->req_id_table_size) < 2) {
>                 dev_err(&sndev->stdev->dev,
> -                       "Not enough requester IDs available.");
> +                       "Not enough requester IDs available\n");
>                 return -EFAULT;
>         }
>
> @@ -928,7 +928,7 @@ static int switchtec_ntb_init_req_id_table(struct switchtec_ntb *sndev)
>         if (rc == -EIO) {
>                 error = ioread32(&sndev->mmio_self_ctrl->req_id_error);
>                 dev_err(&sndev->stdev->dev,
> -                       "Error setting up the requester ID table: %08x",
> +                       "Error setting up the requester ID table: %08x\n",
>                         error);
>         }
>
> @@ -974,7 +974,7 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
>                                                  GFP_KERNEL);
>         if (!sndev->self_shared) {
>                 dev_err(&sndev->stdev->dev,
> -                       "unable to allocate memory for shared mw");
> +                       "unable to allocate memory for shared mw\n");
>                 return -ENOMEM;
>         }
>
> @@ -1004,7 +1004,7 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
>                 bar_error = ioread32(&ctl->bar_error);
>                 lut_error = ioread32(&ctl->lut_error);
>                 dev_err(&sndev->stdev->dev,
> -                       "Error setting up shared MW: %08x / %08x",
> +                       "Error setting up shared MW: %08x / %08x\n",
>                         bar_error, lut_error);
>                 goto unalloc_and_exit;
>         }
> @@ -1015,7 +1015,7 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
>                 goto unalloc_and_exit;
>         }
>
> -       dev_dbg(&sndev->stdev->dev, "Shared MW Ready");
> +       dev_dbg(&sndev->stdev->dev, "Shared MW Ready\n");
>         return 0;
>
>  unalloc_and_exit:
> @@ -1056,8 +1056,8 @@ static irqreturn_t switchtec_ntb_message_isr(int irq, void *dev)
>                 u64 msg = ioread64(&sndev->mmio_self_dbmsg->imsg[i]);
>
>                 if (msg & NTB_DBMSG_IMSG_STATUS) {
> -                       dev_dbg(&sndev->stdev->dev, "message: %d %08x\n", i,
> -                               (u32)msg);
> +                       dev_dbg(&sndev->stdev->dev, "message: %d %08x\n",
> +                               i, (u32)msg);
>                         iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);
>
>                         if (i == LINK_MESSAGE)
> @@ -1085,7 +1085,7 @@ static int switchtec_ntb_init_db_msg_irq(struct switchtec_ntb *sndev)
>                message_irq == event_irq)
>                 message_irq++;
>
> -       dev_dbg(&sndev->stdev->dev, "irqs - event: %d, db: %d, msgs: %d",
> +       dev_dbg(&sndev->stdev->dev, "irqs - event: %d, db: %d, msgs: %d\n",
>                 event_irq, doorbell_irq, message_irq);
>
>         for (i = 0; i < idb_vecs - 4; i++)
> @@ -1135,7 +1135,7 @@ static int switchtec_ntb_add(struct device *dev,
>                 return -ENODEV;
>
>         if (stdev->partition_count != 2)
> -               dev_warn(dev, "ntb driver only supports 2 partitions");
> +               dev_warn(dev, "ntb driver only supports 2 partitions\n");
>
>         sndev = kzalloc_node(sizeof(*sndev), GFP_KERNEL, dev_to_node(dev));
>         if (!sndev)
> @@ -1165,7 +1165,7 @@ static int switchtec_ntb_add(struct device *dev,
>
>         stdev->sndev = sndev;
>         stdev->link_notifier = switchtec_ntb_link_notification;
> -       dev_info(dev, "NTB device registered");
> +       dev_info(dev, "NTB device registered\n");
>
>         return 0;
>
> @@ -1175,7 +1175,7 @@ static int switchtec_ntb_add(struct device *dev,
>         switchtec_ntb_deinit_shared_mw(sndev);
>  free_and_exit:
>         kfree(sndev);
> -       dev_err(dev, "failed to register ntb device: %d", rc);
> +       dev_err(dev, "failed to register ntb device: %d\n", rc);
>         return rc;
>  }
>
> @@ -1194,7 +1194,7 @@ void switchtec_ntb_remove(struct device *dev,
>         switchtec_ntb_deinit_db_msg_irq(sndev);
>         switchtec_ntb_deinit_shared_mw(sndev);
>         kfree(sndev);
> -       dev_info(dev, "ntb device unregistered");
> +       dev_info(dev, "ntb device unregistered\n");
>  }
>
>  static struct class_interface switchtec_interface  = {
>
